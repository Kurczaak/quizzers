import 'package:flutter/material.dart';
import 'package:quizzers/UI/model/question_ui_model.dart';
import 'package:quizzers/UI/widgets/question_widget.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList(
      {super.key, required this.questions, required this.onSelected});

  final List<QuestionUIModel> questions;
  final void Function(QuestionUIModel question) onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return QuestionWidget(
            question: question,
            onSelected: onSelected,
          );
        });
  }
}