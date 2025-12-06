import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._private();
  static Database? _database;
  static const _dbName = "quiz.db";
  static const _dbVersion = 1;

  DatabaseHelper._private();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Category (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE Question (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        optionA TEXT NOT NULL,
        optionB TEXT NOT NULL,
        optionC TEXT NOT NULL,
        optionD TEXT NOT NULL,
        correctAnswer TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE QuestionCategory (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        questionId INTEGER NOT NULL,
        categoryId INTEGER NOT NULL,
        FOREIGN KEY (questionId) REFERENCES Question(id),
        FOREIGN KEY (categoryId) REFERENCES Category(id)
      );
    ''');

    await _insertJsonData(db);
  }

  Future<void> _insertJsonData(Database db) async {
    try {
      final categoryData = await rootBundle.loadString('assets/data/categories.json');
      final List categories = json.decode(categoryData);

      for (var item in categories) {
        await db.insert("Category", {"name": item["name"]});
      }

      final questionData = await rootBundle.loadString('assets/data/questions.json');
      final dynamic decoded = json.decode(questionData);
      final List questions = decoded is List ? decoded : decoded["questions"];

      for (var q in questions) {
        int qId = await db.insert("Question", {
          "content": q["content"],
          "optionA": q["optionA"],
          "optionB": q["optionB"],
          "optionC": q["optionC"],
          "optionD": q["optionD"],
          "correctAnswer": q["correctAnswer"],
        });

        await db.insert("QuestionCategory", {
          "questionId": qId,
          "categoryId": q["categoryId"],
        });
      }
    } catch (e) {
      rethrow;
    }
  }
}