import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzers/di/injection.dart';
import 'package:quizzers/presentation/bloc/quiz_bloc.dart';
import 'package:quizzers/presentation/model/question_ui_model.dart';
import 'package:quizzers/presentation/widgets/questions_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz App'),
      ),
      body: BlocProvider(
        create: (context) =>
            getIt<QuizBloc>()..add(const QuizEvent.loadQuestions()),
        child: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) => state.map(
            initial: (_) => const _EntryWidget(),
            loading: (_) => const _LoadingWidget(),
            loaded: (state) => _LoadedWidget(
              questions: state.questions,
              showAnswers: state.isSubmitted,
            ),
            error: (_) => const _ErrorWidget(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO:
          // Handle the "Send" button press
          // You can access the selected answers using the selectedAnswer list
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}

class _EntryWidget extends StatelessWidget {
  const _EntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Entry Widget'));
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget(
      {super.key, required this.questions, required this.showAnswers});

  final List<QuestionUIModel> questions;
  final bool showAnswers;

  @override
  Widget build(BuildContext context) {
    return QuestionsList(
      showIsCorrect: showAnswers,
      questions: questions,
      onSelected: (question) {
        context.read<QuizBloc>().add(QuizEvent.answerSelected(question));
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Error Widget'));
  }
}

class _SubmittedWidget extends StatelessWidget {
  const _SubmittedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Submitted Widget'));
  }
}
