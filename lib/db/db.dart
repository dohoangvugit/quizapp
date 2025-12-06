import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/question.dart';

class QuizDb {
  static final QuizDb _instance = QuizDb._internal();
  factory QuizDb() => _instance;
  QuizDb._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'quiz.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT,
        options TEXT,
        correctIndex INTEGER
      )
    ''');

    // Insert vài câu hỏi mẫu
    await _seedData(db);
  }

  Future<void> _seedData(Database db) async {
    final sampleQuestions = [
      Question(
        question: 'Thủ đô của Việt Nam là gì?',
        options: ['Hà Nội', 'Hải Phòng', 'Đà Nẵng', 'TP.HCM'],
        correctIndex: 0,
      ),
      Question(
        question: '2 + 2 = ?',
        options: ['3', '4', '5', '22'],
        correctIndex: 1,
      ),
    ];

    for (var q in sampleQuestions) {
      await db.insert('questions', q.toMap());
    }
  }

  Future<List<Question>> getAllQuestions() async {
    final db = await database;
    final result = await db.query('questions');
    return result.map((e) => Question.fromMap(e)).toList();
  }
}
