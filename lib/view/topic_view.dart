import 'package:flutter/material.dart';
import '../repository/quiz_repository.dart';
import 'question_view.dart';

class TopicView extends StatefulWidget {
  const TopicView({super.key});

  @override
  State<TopicView> createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> {
  List topics = [];
  final repo = QuizRepository();

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  Future<void> _loadTopics() async {
    final data = await repo.getTopics();
    setState(() => topics = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh mục chủ đề"),
        backgroundColor: Colors.blue,
      ),

      body: topics.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final t = topics[index];

                return ListTile(
                  title: Text(t.name),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuestionView(
                          topicId: t.id,
                          topicName: t.name,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
