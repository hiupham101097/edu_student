// widgets/chat_input.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../controller/bloc/webview/webview_bloc.dart';
import '../../../../../controller/bloc/webview/webview_event.dart';
import '../../../../_variables/value/app_style.dart';

class WebviewChat extends StatefulWidget {
  final TextEditingController controller;
  final double length;
  final VoidCallback onTapDown;
  final VoidCallback onTapUp;
  final dynamic webViewController;

  const WebviewChat({
    super.key,
    required this.controller,
    required this.length,
    required this.onTapDown,
    required this.onTapUp,
    required this.webViewController,
  });

  @override
  State<WebviewChat> createState() => _WebviewChatState();
}

class _WebviewChatState extends State<WebviewChat> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => widget.onTapDown(),
      onTapUp: (_) => widget.onTapUp(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: BoxDecoration(
          color: AppStyle.colors[1][0],
          border: Border.all(color: AppStyle.colors[1][6]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppStyle.colors[1][4],
                    minimumSize:
                        Size(MediaQuery.of(context).size.width / 14, 10),
                  ),
                  onPressed: () {
                    widget.webViewController!.evaluateJavascript(
                      source: 'openModalFile()',
                    );
                  },
                  child: Icon(
                    Icons.file_upload,
                    size: 13,
                    color: AppStyle.colors[1][7],
                  ),
                ),
                Container(
                  width: widget.length,
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCheck = widget.controller.text.isNotEmpty;
                        context
                            .read<WebviewBloc>()
                            .add(WebviewModelChange("V"));
                      });
                    },
                    child: TextFormField(
                      controller: widget.controller,
                      focusNode: FocusNode(),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        border: InputBorder.none,
                        hintText: "Nhập nội dung tin nhắn",
                        hintStyle: TextStyle(fontSize: 13),
                      ),
                      scrollPadding: const EdgeInsets.all(10),
                      style: const TextStyle(fontSize: 15),
                      maxLines: 9999,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                )
              ],
            ),
            widget.controller.text == ""
                ? TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppStyle.colors[2][0],
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 10, 10),
                    ),
                    onPressed: () {
                      widget.webViewController
                          .evaluateJavascript(source: 'sendLikeEvent()');
                    },
                    child: const Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 13,
                    ),
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppStyle.colors[2][0],
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 10, 10),
                    ),
                    onPressed: () {
                      widget.webViewController.evaluateJavascript(
                          source: 'sendEvent("${widget.controller.text}")');
                      widget.controller.text = "";
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.send,
                      size: 13,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
