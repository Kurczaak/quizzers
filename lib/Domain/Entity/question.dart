import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String question,
    required List<Answer> answers,
    required int correctAnswerIndex,
  }) = _Question;
}

@freezed
class Answer with _$Answer {
  const factory Answer({
    required String answer,
  }) = _Answer;
}
