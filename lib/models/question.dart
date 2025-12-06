class Question {
  final int? id;
  final String content;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctAnswer; // "A"/"B"/"C"/"D"

  Question({
    this.id,
    required this.content,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctAnswer,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "content": content,
      "optionA": optionA,
      "optionB": optionB,
      "optionC": optionC,
      "optionD": optionD,
      "correctAnswer": correctAnswer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map["id"] as int?,
      content: map["content"] as String,
      optionA: map["optionA"] as String,
      optionB: map["optionB"] as String,
      optionC: map["optionC"] as String,
      optionD: map["optionD"] as String,
      correctAnswer: map["correctAnswer"] as String,
    );
  }
}
