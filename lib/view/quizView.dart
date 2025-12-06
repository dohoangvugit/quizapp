import 'package:flutter/material.dart';

class Question {
  final String question;
  final List<String> answers;
  final int correctIndex;

  Question({
    required this.question,
    required this.answers,
    required this.correctIndex,
  });
}

class quizView extends StatefulWidget {
  const quizView({super.key});

  @override
  State<quizView> createState() => _quizViewState();
}

class _quizViewState extends State<quizView> {
  final List<Question> _questions = [
    Question(
      question: 'Thủ đô của Việt Nam là gì?',
      answers: ['Hà Nội', 'Đà Nẵng', 'TP.HCM', 'Huế'],
      correctIndex: 0,
    ),
    Question(
      question: '2 + 2 = ?',
      answers: ['3', '4', '5', '22'],
      correctIndex: 1,
    ),
    Question(
      question: 'Flutter dùng ngôn ngữ nào?',
      answers: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctIndex: 2,
    ),
  ];

  int _currentIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;

  void _onSelectAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedIndex = index;
      _answered = true;
      if (index == _questions[_currentIndex].correctIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
        _answered = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Hoàn thành!'),
            content: Text('Điểm của bạn: $_score / ${_questions.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _currentIndex = 0;
                    _score = 0;
                    _selectedIndex = null;
                    _answered = false;
                  });
                },
                child: const Text('Chơi lại'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Câu ${_currentIndex + 1}/${_questions.length}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            question.question,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 24),

          ...List.generate(question.answers.length, (index) {
            final answer = question.answers[index];

            Color? color;
            if (_answered) {
              if (index == question.correctIndex) {
                color = Colors.green; 
              } else if (_selectedIndex == index &&
                  _selectedIndex != question.correctIndex) {
                color = Colors.red; 
              }
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                ),
                onPressed: () => _onSelectAnswer(index),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(answer),
                ),
              ),
            );
          }),

          const Spacer(),
          Text(
            'Điểm: $_score',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _answered ? _nextQuestion : null,
            child: Text(
              _currentIndex == _questions.length - 1
                  ? 'Xem kết quả'
                  : 'Câu tiếp theo',
            ),
          ),
        ],
      ),
    );
  }
}
