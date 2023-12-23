import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedAnswer =
        useState<List<String?>>(List.filled(questions.length, null));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz App'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(questions[index].question),
            subtitle: Column(
              children: questions[index].answers.map((answer) {
                return RadioListTile(
                  title: Text(answer),
                  value: answer,
                  groupValue: selectedAnswer.value[index],
                  onChanged: (value) {
                    // Update the selected answer for the current question
                    selectedAnswer.value = List.from(selectedAnswer.value)
                      ..[index] = value;
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO:
          // Handle the "Send" button press
          // You can access the selected answers using the selectedAnswer list
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> answers;

  Question({required this.question, required this.answers});
}

final List<Question> questions = [
  Question(
    question: 'What is the capital of France?',
    answers: ['Paris', 'London', 'Berlin', 'Madrid'],
  ),
  Question(
    question: 'What is the largest planet in our solar system?',
    answers: ['Jupiter', 'Saturn', 'Mars', 'Earth'],
  ),
  Question(
    question: 'Who painted the Mona Lisa?',
    answers: [
      'Leonardo da Vinci',
      'Pablo Picasso',
      'Vincent van Gogh',
      'Michelangelo'
    ],
  ),
];

List<String> selectedAnswer = List.filled(questions.length, '');
