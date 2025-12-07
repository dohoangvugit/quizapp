import '../db.dart';
import '../models/topic.dart';
import '../models/question.dart';

class QuizRepository {
  Future<List<Topic>> getTopics() async {
    final db = await DatabaseHelper.instance.database;
    final rows = await db.query("topics", orderBy: "id ASC");
    return rows.map((e) => Topic.fromMap(e)).toList();
  }

  Future<List<Question>> getQuestionsByTopic(int topicId) async {
    final db = await DatabaseHelper.instance.database;

    final rows = await db.query(
      "questions",
      where: "topic_id = ?",
      whereArgs: [topicId],
    );

    return rows.map((e) => Question.fromMap(e)).toList();
  }
}
