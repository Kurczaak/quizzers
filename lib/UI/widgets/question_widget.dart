import 'package:flutter/material.dart';
import 'package:quizzers/UI/model/question_ui_model.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
    required this.onSelected,
  });

  final QuestionUIModel question;
  final void Function(QuestionUIModel question) onSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(question.question),
      subtitle: Column(
        children: question.answers.map((answer) {
          return _AnswerWidget(
            answer: answer,
            onSelected: (answer) {
              onSelected(
                question.copyWith(
                  selectedAnswerIndex: question.answers.indexOf(answer),
                ),
              );
            },
            selectedAnswer: question.selectedAnswer,
          );
        }).toList(),
      ),
    );
  }
}

class _AnswerWidget extends StatelessWidget {
  const _AnswerWidget({
    super.key,
    required this.selectedAnswer,
    required this.answer,
    required this.onSelected,
  });

  final AnswerUIModel answer;
  final AnswerUIModel? selectedAnswer;
  final void Function(AnswerUIModel) onSelected;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(answer.answer),
      value: answer,
      groupValue: selectedAnswer,
      onChanged: (value) {
        onSelected(answer);
      },
    );
  }
}
