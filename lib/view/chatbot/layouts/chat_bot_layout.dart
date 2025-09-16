import 'dart:convert';

import 'package:edu_student/controller/bloc/chat_bot/chat_bot_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../controller/bloc/chat_bot/chat_bot_bloc.dart';
import '../../../controller/bloc/chat_bot/chat_bot_state.dart';
import '../../../controller/function/data_example.dart';
import '../../../model/chatbot/message.dart';
import '../../../system/_variables/value/app_style.dart';
import '../../../system/base/model/category/status_bloc.dart';

class ChatBotEduLayout extends StatefulWidget {
  const ChatBotEduLayout({super.key});

  @override
  State<StatefulWidget> createState() => _ChatBotEduLayout();
}

class _ChatBotEduLayout extends State<ChatBotEduLayout> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // List to store chat messages
  final List<Map<String, String>> _messages = [];

  var listMessage = DataViewMessage().listMessage;
  bool isTyping = false;
  void _sendMessage(String? inputDataText) async {
    final inputText = inputDataText!.trim();
    if (inputText.isEmpty) return;
    setState(() {
      _messages.add({
        'sender': 'user',
        'text': inputText,
        'id': (_messages.length + 1).toString(),
      });
      _controller.clear();
    });

    final prompt = '''
        Bạn là trợ lý chăm sóc khách hàng của công ty Cổ Phần Ilean (Toán Cô Yến).

        Hãy trả lời một cách chuyên nghiệp, dễ hiểu, đúng trọng tâm, tránh dùng thuật ngữ kỹ thuật quá nhiều.

        Câu hỏi: $inputText

        Thông tin hỗ trợ:
        - công ty Cổ Phần Ilean (Toán Cô Yến) là cơ sở giáo dục.
        - Bao gồm: lớp vỡ lòng, cấp 1, cấp 2, cấp 3 và luyện thi đại học.

        Sau khi trả lời, vui lòng đính kèm thêm thông tin liên hệ của công ty như sau (để khách tiện liên lạc nếu cần hỗ trợ):
        - 🌐  Website: http://ql.edu.ilearn.net.vn
        - ☎️ Hotline: 089 639 6969

        Trả lời:
      ''';

    

    final response = await Gemini.instance.prompt(parts: [Part.text(prompt)]);
    setState(() {
      isTyping = true;
      _messages.add({
        'sender': 'bot',
        'text': response?.output ?? 'Không có phản hồi',
        'id': (_messages.length + 1).toString(),
      });
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200.0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
    // ignore: use_build_context_synchronously
    context.read<ChatBotBloc>().add(
      SendMessage(
        // ignore: use_build_context_synchronously
        context: context,
        messageChatBot:
            _messages.map((item) {
              return MessageChatBot(
                id: int.tryParse(item['id']!),
                sender: item['sender'] ?? '',
                text: jsonEncode(item['text'].toString()),
              );
            }).toList(),
        view: 'chatbot',
      ),
    );

    // ignore: use_build_context_synchronously
  }

  @override
  void initState() {
    super.initState();

    context.read<ChatBotBloc>().add(ChatBotFetched());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var listChatBot = DataChatBotExsample().listChatBot;

    return BlocBuilder<ChatBotBloc, ChatBotState>(
      builder: (context, state) {
        switch (state.status) {
          case BlocStatus.failure:
            return Scaffold(
              backgroundColor: AppStyle.colors[1][2],
              body: Column(
                children: [
                  Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 200,
                    ),
                  ),
                ],
              ),
            );
          case BlocStatus.success:
            return Scaffold(
              backgroundColor: AppStyle.colors[1][2],
              appBar: AppBar(
                backgroundColor: AppStyle.colors[0][4],
                elevation: 1,
                title: Text(
                  "Trò chuyện cùng Toán Cô Yến AI",
                  style: TextStyle(
                    color: AppStyle.colors[1][0],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: 1 + _messages.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return chatbotScrip(
                            listChatBot,
                            state.messageChatBots!,
                            state.isHistory!,
                            state.isShowHistory!,
                          );
                        } else {
                          return chatbot(index, isTyping);
                        }
                      },
                    ),
                  ),

                  // Input field and send button
                  inputText(),
                ],
              ),
            );

          default:
            return Scaffold(
              backgroundColor: AppStyle.colors[1][2],
              body: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 200,
                ),
              ),
            );
        }
      },
    );
  }

  Widget chatbotScrip(
    List<String> listChatBot,
    List<MessageChatBot> listMessage,
    bool isHistory,
    bool isShowHistory,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final now = DateTime.now();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isHistory
              ? Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      context.read<ChatBotBloc>().add(
                        ChatBotModelChange(isHistory: false, isShowHistory: true) ,
                      );
                    });
                  },
                  child: Text(
                    'Xem lịch sử trò chuyện',
                    style: TextStyle(
                      color: AppStyle.colors[3][5],
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              )
              : Container(),
          isShowHistory
              ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: showHistoryChatBot(listMessage, isShowHistory, screenWidth),
              )
              : const SizedBox(),
          const SizedBox(height: 10.0),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text('${now.day}/${now.month} ${now.hour}:${now.second}'),
            ),
          ),
          Container(
            width: screenWidth - 70.0,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppStyle.colors[1][3],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(6.0),
                bottomLeft: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
              ),
            ),
            child: const Text(
              "Xin chào, bạn đang trò chuyện cùng Toán Cô Yến. Bạn cần hỗ trợ điều gì?",
              style: TextStyle(fontSize: 14.0, fontFamily: 'Inter',),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: screenWidth - 70.0,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppStyle.colors[1][3],
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(6.0),
                bottomLeft: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 16.0,
                      color: AppStyle.colors[3][6],
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Chọn và nhập câu hỏi để bắt đầu.',
                      style: TextStyle(fontSize: 14.0, fontFamily: 'Inter'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...List.generate(listChatBot.length, (i) {
                  final item = listChatBot[i];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isTyping = false;
                            _sendMessage(item);
                          });
                        },
                        child: Container(
                          width: screenWidth,
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: AppStyle.colors[1][5],
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            item.toString(),
                            style: TextStyle(
                              color: AppStyle.colors[3][6],
                              fontSize: 14.0,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  );
                }),
                const Text(
                  'Bạn cần thêm thông tin gì cứ hỏi Toán Cô Yến AI nhé!',
                  style: TextStyle(fontSize: 14.0, fontFamily: 'Inter'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> showHistoryChatBot(
    List<MessageChatBot> listMessage,
    bool isShowHistory,
    double screenWidth,
  ) {
    var rows = <Widget>[];

    for (var item in listMessage) {
      final isUser = item.sender == 'user';
      rows.add(
        Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
             width: screenWidth - 70.0,
            decoration: BoxDecoration(
              color: isUser ? AppStyle.colors[3][1] : AppStyle.colors[1][3],
              borderRadius:
                  isUser
                      ? const BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                        topRight: Radius.circular(6.0),
                      )
                      : const BorderRadius.only(
                        topRight: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                        bottomRight: Radius.circular(6.0),
                      ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
              child: Text(
                jsonDecode(item.text.toString()) ?? '',
                style: TextStyle(fontSize: 14.0, fontFamily: 'Inter'),
              ),
            ),
            // Text(message['text'] ?? ''),
          ),
        ),
      );
      rows.add(const SizedBox(height: 10.0));
    }

    return rows;
  }

  Widget chatbot(int index, bool isTyping) {
    final message = _messages[index - 1];
    final isUser = message['sender'] == 'user';
    final id = message['id'];
    return isUser
        ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0, right: 8.0, left: 24.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppStyle.colors[3][1],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      bottomLeft: Radius.circular(6.0),
                      bottomRight: Radius.circular(6.0),
                    ),
                  ),
                  child: Text(
                    message['text'] ?? '',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Inter',
                      color: isUser ? Colors.black : Colors.black87,
                    ),
                  ),

                  // Text(message['text'] ?? ''),
                ),
              ),
            ),
            !isTyping && int.parse(id!) > _messages.length - 1
                ? Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 2.0,
                    left: 16.0,
                    right: 26.0,
                  ),

                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppStyle.colors[1][3],
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: AppStyle.colors[3][6],
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                )
                : const SizedBox(),
          ],
        )
        : Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 8.0, right: 26.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? AppStyle.colors[3][1] : AppStyle.colors[1][3],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                ),
              ),
              child: Text(
                message['text'] ?? '',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Inter',
                  color: isUser ? Colors.black : Colors.black87,
                ),
              ),
            ),
          ),
        );
  }

  Widget inputText() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (value) {
                      setState(() {
                        isTyping = false;
                      });
                      _sendMessage(_controller.text);
                    },
                    style: TextStyle(fontFamily: 'Inter'),
                    textInputAction: TextInputAction.send,
                    showCursor: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Bạn hỏi, Toán Cô Yến AI trả lời",
                    ),
                  ),
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                isTyping = false;
              });
              _sendMessage(_controller.text);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
