import 'package:flutter/material.dart';
import '../repository/quiz_repository.dart';

class QuestionView extends StatefulWidget {
  final int topicId;
  final String topicName;

  const QuestionView({
    super.key,
    required this.topicId,
    required this.topicName,
  });

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  List questions = [];
  final repo = QuizRepository();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  // Future<void> _loadQuestions() async {
  //   final data = await repo.getQuestionsByTopic(widget.topicId);
  //   setState(() => questions = data);
  // }
  Future<void> _loadQuestions() async {
  print("LOAD QUESTIONS: topicId = ${widget.topicId}");

  final data = await repo.getQuestionsByTopic(widget.topicId);

  print("QUERY RESULT:");
  print(data);

  setState(() {
    questions = data;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topicName),
        backgroundColor: Colors.blue,
      ),

      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final q = questions[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(q.text,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 10),
                        Text("A. ${q.a}"),
                        Text("B. ${q.b}"),
                        Text("C. ${q.c}"),
                        Text("D. ${q.d}"),
                        const SizedBox(height: 8),
                        Text("Đáp án đúng: ${q.correct}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
