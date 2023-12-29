part of 'quiz_bloc.dart';

@freezed
abstract class QuizEvent with _$QuizEvent {
  const factory QuizEvent.loadQuestions() = LoadQuestions;
  const factory QuizEvent.answerSelected(QuestionUIModel question) =
      AnswerSelected;

  const factory QuizEvent.submit() = Submit;
  const factory QuizEvent.reset() = Reset;
  const factory QuizEvent.changeCategory(String category) = ChangeCategory;
  const factory QuizEvent.difficultyChanged(QuestionDifficulty difficulty) =
      DifficultyChanged;
}
