import 'dart:convert';

class Question {
  final int? id;
  final String question;
  final List<String> options;
  final int correctIndex;

  Question({
    this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': jsonEncode(options),
      'correctIndex': correctIndex,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      question: map['question'],
      options: List<String>.from(jsonDecode(map['options'])),
      correctIndex: map['correctIndex'],
    );
  }
}
