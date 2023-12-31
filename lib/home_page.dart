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
        create: (context) => getIt<QuizBloc>(),
        child: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) => state.map(
            initial: (state) => _EntryWidget(
              difficulty: state.difficulty,
            ),
            loading: (_) => const _LoadingWidget(),
            loaded: (state) => _LoadedWidget(
              questions: state.questions,
              showAnswers: state.isSubmitted,
            ),
            error: (_) => const _ErrorWidget(),
          ),
        ),
      ),
    );
  }
}

class _EntryWidget extends StatelessWidget {
  const _EntryWidget({
    super.key,
    required this.difficulty,
  });

  final QuestionDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Enter your category here',
            ),
            onChanged: (value) {
              context.read<QuizBloc>().add(QuizEvent.changeCategory(value));
            },
          ),
          const SizedBox(height: 20),
          const Text('Select difficulty'),
          DropdownButton<QuestionDifficulty>(
            value: context.select((QuizBloc bloc) => difficulty),
            onChanged: (value) {
              context.read<QuizBloc>().add(QuizEvent.difficultyChanged(
                  value ?? QuestionDifficulty.easy));
            },
            items: QuestionDifficulty.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ))
                .toList(),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<QuizBloc>().add(const QuizEvent.loadQuestions());
              },
              child: const Text('Start'),
            ),
          ),
        ],
      ),
    );
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
    return Column(
      children: [
        Expanded(
          child: QuestionsList(
            showIsCorrect: showAnswers,
            questions: questions,
            onSelected: (question) {
              context.read<QuizBloc>().add(showAnswers
                  ? const QuizEvent.reset()
                  : QuizEvent.answerSelected(question));
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showAnswers
                ? context.read<QuizBloc>().add(const QuizEvent.reset())
                : context.read<QuizBloc>().add(const QuizEvent.submit());
          },
          child: Text(showAnswers ? 'Reset' : 'Submit'), // TODO extract to l10n
        ),
        const SizedBox(height: 40),
      ],
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
