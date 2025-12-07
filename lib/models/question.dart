class Question {
  final int id;
  final int topicId;
  final String text;
  final String a;
  final String b;
  final String c;
  final String d;
  final String correct;

  Question({
    required this.id,
    required this.topicId,
    required this.text,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.correct,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map["id"],
      topicId: map["topic_id"],
      text: map["question_text"],
      a: map["option_a"],
      b: map["option_b"],
      c: map["option_c"],
      d: map["option_d"],
      correct: map["correct_option"],
    );
  }
}
