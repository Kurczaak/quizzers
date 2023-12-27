import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizzers/Domain/Entity/question.dart';

part 'question_ui_model.freezed.dart';

@freezed
abstract class QuestionUIModel with _$QuestionUIModel {
  const factory QuestionUIModel({
    required String question,
    required List<AnswerUIModel> answers,
    required int correctAnswerIndex,
    required int? selectedAnswerIndex,
  }) = _QuestionUIModel;

  const QuestionUIModel._();

  bool get isAnswered => selectedAnswerIndex != null;

  bool get isCorrectAnswered => selectedAnswerIndex == correctAnswerIndex;

  AnswerUIModel get correctAnswer => answers[correctAnswerIndex];
  AnswerUIModel? get selectedAnswer =>
      selectedAnswerIndex == null ? null : answers[selectedAnswerIndex!];
}

@freezed
abstract class AnswerUIModel with _$AnswerUIModel {
  const factory AnswerUIModel({
    required String answer,
  }) = _AnswerUIModel;
}

extension QuestionX on Question {
  QuestionUIModel toUIModel() => QuestionUIModel(
        question: question,
        answers: answers.map((e) => AnswerUIModel(answer: e.answer)).toList(),
        correctAnswerIndex: correctAnswerIndex,
        selectedAnswerIndex: null,
      );
}
