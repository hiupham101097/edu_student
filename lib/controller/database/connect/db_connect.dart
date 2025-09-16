
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../model/chatbot/message.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'chatbot.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ChatBot (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sender TEXT,
        text TEXT
      )
    ''');
  }

  Future<void> insertChatBotList(List<MessageChatBot> messages) async {
    final db = await database;

    // Dùng batch để thực hiện nhiều thao tác insert hiệu quả hơn
    final batch = db.batch();

    for (var message in messages) {
      batch.insert('ChatBot', {
        'id': message.id,
        'sender': message.sender,
        'text': message.text,
      });
    }

    try {
      await batch.commit(noResult: true);
    } catch (e) {
      // ignore: avoid_print
      print('Batch commit error: $e');
    }
  }

  Future<void> insertListWithAutoId(List<MessageChatBot> messages) async {
  final db = await database;

  for (var message in messages) {
    String newId = message.id.toString();

    // Lặp để tìm ID chưa tồn tại
    while (true) {
      final existing = await db.query(
        'ChatBot',
        where: 'id = ?',
        whereArgs: [newId],
      );

      if (existing.isEmpty) break;

      final intId = int.tryParse(newId) ?? 0;
      newId = (intId + 1).toString();
    }

    // Insert bản ghi với id không trùng
    await db.insert('ChatBot', {
      'id': newId,
      'sender': message.sender,
      'text': message.text,
    });
  }
}

  Future<List<MessageChatBot>> getAllMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ChatBot');

    return List.generate(maps.length, (i) {
      return MessageChatBot(
        id: maps[i]['id'],
        sender: maps[i]['sender'],
        text: maps[i]['text'],
      );
    });
  }
}
