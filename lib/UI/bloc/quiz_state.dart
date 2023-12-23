part of 'quiz_bloc.dart';

@freezed
abstract class QuizState with _$QuizState {
  const factory QuizState({
    required QuizStateStatus status,
    required List<QuestionUIModel>? questions,
  }) = _QuizState;
}

@freezed
abstract class QuizStateStatus with _$QuizStateStatus {
  const factory QuizStateStatus.initial() = _Initial;
  const factory QuizStateStatus.loading() = _Loading;
  const factory QuizStateStatus.loaded() = _Loaded;
  const factory QuizStateStatus.error() = _Error;
  const factory QuizStateStatus.submitted() = _Submitted;
}
