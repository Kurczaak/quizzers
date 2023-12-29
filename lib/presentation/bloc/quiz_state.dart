part of 'quiz_bloc.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial({
    @Default('') String category,
    @Default(QuestionDifficulty.easy) QuestionDifficulty difficulty,
  }) = _Initial;
  const factory QuizState.loading() = _Loading;
  factory QuizState.loaded({
    required List<QuestionUIModel> questions,
    @Default(false) bool isSubmitted,
  }) = _Loaded;
  const factory QuizState.error() = _Error;
}

extension LoadedX on _Loaded {
  bool get isAllAnswered =>
      questions.every((element) => element.selectedAnswerIndex != null);
}
