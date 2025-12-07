// import 'database_helper.dart';
// import '../models/category.dart';
// import '/../models/question.dart';
// import '/../models/question_category.dart';

// class QuizRepository {

//   Future<int> insertCategory(Category category) async {
//     final db = await DatabaseHelper.instance.database;
//     return await db.insert("Category", category.toMap());
//   }

//   Future<List<Category>> getAllCategories() async {
//     final db = await DatabaseHelper.instance.database;
//     final rows = await db.query("Category", orderBy: "id DESC");
//     return rows.map((r) => Category.fromMap(r)).toList();
//   }

//   Future<int> deleteCategory(int id) async {
//     final db = await DatabaseHelper.instance.database;
//     await db.delete("QuestionCategory", where: "categoryId = ?", whereArgs: [id]);
//     return await db.delete("Category", where: "id = ?", whereArgs: [id]);
//   }

//   Future<int> insertQuestion(Question question) async {
//     final db = await DatabaseHelper.instance.database;
//     return await db.insert("Question", question.toMap());
//   }

//   Future<List<Question>> getAllQuestions() async {
//     final db = await DatabaseHelper.instance.database;
//     final rows = await db.query("Question", orderBy: "id DESC");
//     return rows.map((r) => Question.fromMap(r)).toList();
//   }

//   Future<int> deleteQuestion(int id) async {
//     final db = await DatabaseHelper.instance.database;
//     await db.delete("QuestionCategory", where: "questionId = ?", whereArgs: [id]);
//     return await db.delete("Question", where: "id = ?", whereArgs: [id]);
//   }

//   Future<int> linkQuestionCategory(QuestionCategory qc) async {
//     final db = await DatabaseHelper.instance.database;
//     return await db.insert("QuestionCategory", qc.toMap());
//   }

//   Future<List<Question>> getQuestionsByCategory(int categoryId) async {
//     final db = await DatabaseHelper.instance.database;
//     final result = await db.rawQuery('''
//       SELECT q.* FROM Question q
//       JOIN QuestionCategory qc ON q.id = qc.questionId
//       WHERE qc.categoryId = ?
//     ''', [categoryId]);

//     return result.map((r) => Question.fromMap(r)).toList();
//   }

//   Future<List<int>> getCategoryIdsOfQuestion(int questionId) async {
//     final db = await DatabaseHelper.instance.database;
//     final rows = await db.query(
//       "QuestionCategory",
//       where: "questionId = ?",
//       whereArgs: [questionId],
//     );

//     return rows.map((r) => r["categoryId"] as int).toList();
//   }
// }
