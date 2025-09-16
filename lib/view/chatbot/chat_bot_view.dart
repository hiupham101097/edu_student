
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/bloc/chat_bot/chat_bot_bloc.dart';
import '../../controller/bloc/chat_bot/chat_bot_event.dart';
import 'layouts/chat_bot_layout.dart';

class ChatBotView extends StatelessWidget {
  // ignore: use_super_parameters
  ChatBotView({Key? key}) : super(key: key);

  final viewKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatBotBloc(context)..add(ChatBotFetched()),
        ),
      ],
      child: ChatBotEduLayout(),
    );
  }
}
