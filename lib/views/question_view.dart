import 'package:flutter/material.dart';
import '../controllers/quiz_controller.dart';
import '../models/question.dart';

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
  List<Question> questions = [];
  final repo = QuizRepository();

  int currentIndex = 0;       
  String? selectedAnswer;      
  bool answerChecked = false;  

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final data = await repo.getQuestionsByTopic(widget.topicId);
    setState(() => questions = data);
  }

  Color getOptionColor(String option, Question q) {
    if (!answerChecked) return Colors.black;

    if (option == q.correct) return Colors.green;
    if (option == selectedAnswer && selectedAnswer != q.correct) {
      return Colors.red;
    }
    return Colors.black;
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedAnswer = null;
        answerChecked = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Hoàn thành"),
          content: const Text("Bạn đã trả lời xong tất cả câu hỏi!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
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
          : _buildQuestion(questions[currentIndex]),
    );
  }

  Widget _buildQuestion(Question q) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Câu ${currentIndex + 1}/${questions.length}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Text(
            q.text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),

          _optionButton("A", q.a, q),
          const SizedBox(height: 10),

          _optionButton("B", q.b, q),
          const SizedBox(height: 10),

          _optionButton("C", q.c, q),
          const SizedBox(height: 10),

          _optionButton("D", q.d, q),
          const SizedBox(height: 20),

          if (answerChecked)
            ElevatedButton(
              onPressed: nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                currentIndex == questions.length - 1
                    ? "Hoàn thành"
                    : "Câu tiếp theo",
                style: const TextStyle(fontSize: 18),
              ),
            ),
        ],
      ),
    );
  }

  Widget _optionButton(String option, String text, Question q) {
    return InkWell(
      onTap: () {
        if (answerChecked) return;
        setState(() {
          selectedAnswer = option;
          answerChecked = true;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: getOptionColor(option, q)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "$option. $text",
          style: TextStyle(
            fontSize: 16,
            color: getOptionColor(option, q),
          ),
        ),
      ),
    );
  }
}
