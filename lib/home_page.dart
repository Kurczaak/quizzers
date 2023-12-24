import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzers/UI/bloc/quiz_bloc.dart';
import 'package:quizzers/UI/model/question_ui_model.dart';
import 'package:quizzers/UI/widgets/questions_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz App'),
      ),
      body: BlocProvider(
        create: (context) => QuizBloc()
          ..add(
            const QuizEvent.loadQuestions(),
          ),
        child: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) => state.status.when(
            initial: () => const _EntryWidget(),
            loading: () => const _LoadingWidget(),
            loaded: () => state.questions == null
                ? const _LoadingWidget()
                : _LoadedWidget(
                    questions: state.questions!,
                  ),
            error: () => const _ErrorWidget(),
            submitted: () => const _SubmittedWidget(),
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
  const _LoadedWidget({super.key, required this.questions});

  final List<QuestionUIModel> questions;

  @override
  Widget build(BuildContext context) {
    return QuestionsList(
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
