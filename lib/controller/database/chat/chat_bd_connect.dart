// ignore_for_file: constant_identifier_names

import 'package:sqflite/sqflite.dart';

class HistoryChatBot {
  static const String SESSIONS_TABLE_NAME = "CHATBOT";
  static const String HISTORY_SENDER = "sender";
  static const String SESSIONS_TEXT = "text";
  static const String SESSIONS_ID = "id";

  static void createTable(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $SESSIONS_TABLE_NAME (
        $HISTORY_SENDER TEXT NOT NULL,
        $SESSIONS_TEXT TEXT NOT NULL,
        PRIMARY KEY ($SESSIONS_ID)
      )
    ''');
  }
}
