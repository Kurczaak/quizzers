import 'package:flutter/material.dart';
import 'package:quizzers/presentation/model/question_ui_model.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
    required this.onSelected,
    required this.showIsCorrect,
  });

  final QuestionUIModel question;
  final void Function(QuestionUIModel question) onSelected;
  final bool showIsCorrect;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: showIsCorrect
              ? question.isCorrectAnswered
                  ? Colors.green
                  : Colors.red
              : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(question.question),
        subtitle: Column(
          children: question.answers.map((answer) {
            return _AnswerWidget(
              answer: answer,
              onSelected: (answer) {
                if (showIsCorrect) return;
                onSelected(
                  question.copyWith(
                    selectedAnswerIndex: question.answers.indexOf(answer),
                  ),
                );
              },
              selectedAnswer: question.selectedAnswer,
              isCorrect: answer == question.correctAnswer,
              showIsCorrect: showIsCorrect,
            );
          }).toList(),
        ),
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
    required this.isCorrect,
    required this.showIsCorrect,
  });

  final AnswerUIModel answer;
  final AnswerUIModel? selectedAnswer;
  final void Function(AnswerUIModel) onSelected;
  final bool isCorrect;
  final bool showIsCorrect;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(
        answer.answer,
        style: TextStyle(color: _color),
      ),
      value: answer,
      groupValue: selectedAnswer,
      onChanged: (value) {
        onSelected(answer);
      },
    );
  }

  Color get _color => showIsCorrect
      ? isCorrect
          ? answer == selectedAnswer
              ? Colors.green
              : Colors.red
          : Colors.black
      : Colors.black;
}
