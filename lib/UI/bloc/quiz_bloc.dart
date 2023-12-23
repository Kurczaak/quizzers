import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizzers/UI/model/question_ui_model.dart';

part 'quiz_bloc.freezed.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc()
      : super(const QuizState(
          status: QuizStateStatus.initial(),
          questions: null,
        )) {
    on<QuizEvent>((event, emit) {
      event.map(
        loadQuestions: (loadQuestions) => _onLoadQuestions(loadQuestions, emit),
        answerSelected: (answerSelected) =>
            _onAnswerSelected(answerSelected, emit),
        submit: (submit) => _onSubmit(submit, emit),
      );
    });
  }

  void _onSubmit(Submit event, Emitter emit) {
    emit(state.copyWith(status: const QuizStateStatus.submitted()));
  }

  Future<void> _onLoadQuestions(LoadQuestions event, Emitter emit) async {
    final questions = mockQuestions;
    emit(state.copyWith(
      status: const QuizStateStatus.loaded(),
      questions: questions,
    ));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter emit) {
    final questions = state.questions;
    if (questions == null) return;

    final updatedQuestion = questions
        .firstWhereOrNull(
            (element) => element.question == event.question.question)
        ?.copyWith(
          selectedAnswerIndex: event.question.selectedAnswerIndex,
        );

    print(updatedQuestion);

    if (updatedQuestion == null) return;

    final updatedQuestions = questions
        .map((question) => question.question == updatedQuestion.question
            ? updatedQuestion.copyWith(
                selectedAnswerIndex: event.question.selectedAnswerIndex,
              )
            : question)
        .toList();

    emit(
      state.copyWith(
        questions: updatedQuestions,
        status: const QuizStateStatus.loaded(),
      ),
    );
  }
}

// TODO: Remove. Temp mock data
List<QuestionUIModel> mockQuestions = [
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