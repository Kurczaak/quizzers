import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:quizzers/domain/use_case/get_questions_use_case.dart';
import 'package:quizzers/presentation/model/question_ui_model.dart';

part 'quiz_bloc.freezed.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

@Injectable()
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc(this._getQuestionsUseCase) : super(const QuizState.initial()) {
    on<QuizEvent>((event, emit) async {
      await event.map(
        loadQuestions: (loadQuestions) async =>
            await _onLoadQuestions(loadQuestions, emit),
        answerSelected: (answerSelected) async =>
            _onAnswerSelected(answerSelected, emit),
        submit: (submit) async => _onSubmit(submit, emit),
        changeCategory: (changeCategory) async =>
            _onChangeCategory(changeCategory, emit),
        difficultyChanged: (difficultyChanged) async =>
            _onDifficultyChanged(difficultyChanged, emit),
        reset: (reset) async => _onReset(reset, emit),
      );
    });
  }

  final GetQuestionsUseCase _getQuestionsUseCase;

  void _onReset(Reset event, Emitter emit) {
    emit(const QuizState.initial());
  }

  void _onDifficultyChanged(
      DifficultyChanged event, Emitter<QuizState> emit) async {
    state.mapOrNull(initial: (initial) {
      emit(initial.copyWith(difficulty: event.difficulty));
    });
  }

  void _onChangeCategory(ChangeCategory event, Emitter<QuizState> emit) async {
    state.mapOrNull(initial: (initial) {
      emit(initial.copyWith(category: event.category));
    });
  }

  void _onSubmit(Submit event, Emitter emit) {
    state.mapOrNull(loaded: (loaded) {
      if (loaded.isAllAnswered) {
        emit(loaded.copyWith(isSubmitted: true));
      }
    });
  }

  Future<void> _onLoadQuestions(LoadQuestions event, Emitter emit) async {
    await state.mapOrNull(initial: (initial) async {
      emit(const QuizState.loading());

      final result = await _getQuestionsUseCase.getQuestions(
          category: initial.category,
          difficulty: initial.difficulty.name,
          questionsCount: 4,
          answersCount: 4);

      emit(
        result.fold(
            (l) => const QuizState.error(),
            (r) => QuizState.loaded(
                questions: r.map((e) => e.toUIModel()).toList())),
      );
    });
  }

  void _onAnswerSelected(AnswerSelected event, Emitter emit) {
    state.mapOrNull(loaded: (state) {
      final updatedQuestion = state.questions
          .firstWhereOrNull(
              (element) => element.question == event.question.question)
          ?.copyWith(
            selectedAnswerIndex: event.question.selectedAnswerIndex,
          );

      if (updatedQuestion == null) return;

      final updatedQuestions = state.questions
          .map((question) => question.question == updatedQuestion.question
              ? updatedQuestion.copyWith(
                  selectedAnswerIndex: event.question.selectedAnswerIndex,
                )
              : question)
          .toList();

      emit(
        state.copyWith(
          questions: updatedQuestions,
        ),
      );
    });
  }
}
