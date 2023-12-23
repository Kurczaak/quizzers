import 'package:flutter/material.dart';
import 'package:quizzers/UI/model/question_ui_model.dart';
import 'package:quizzers/UI/widgets/question_widget.dart';

// TODO: Remove. Temp mock data
List<QuestionUIModel> questions = [
  const QuestionUIModel(
    question: 'What is the capital of France?',
    answers: [
      AnswerUIModel(answer: 'Paris'),
      AnswerUIModel(answer: 'London'),
      AnswerUIModel(answer: 'Berlin'),
      AnswerUIModel(answer: 'Madrid'),
    ],
    correctAnswerIndex: 0,
    selectedAnswerIndex: null,
  ),
  const QuestionUIModel(
    question: 'Who painted the Mona Lisa?',
    answers: [
      AnswerUIModel(answer: 'Leonardo da Vinci'),
      AnswerUIModel(answer: 'Pablo Picasso'),
      AnswerUIModel(answer: 'Vincent van Gogh'),
      AnswerUIModel(answer: 'Michelangelo'),
    ],
    correctAnswerIndex: 0,
    selectedAnswerIndex: null,
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz App'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return QuestionWidget(
              question: question,
              onSelected: (question) {
                // TODO: handle on question selected,
              });
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
