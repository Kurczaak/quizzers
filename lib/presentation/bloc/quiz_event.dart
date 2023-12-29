part of 'quiz_bloc.dart';

@freezed
abstract class QuizEvent with _$QuizEvent {
  const factory QuizEvent.loadQuestions() = LoadQuestions;
  const factory QuizEvent.answerSelected(QuestionUIModel question) =
      AnswerSelected;
  const factory QuizEvent.submit() = Submit;
}
