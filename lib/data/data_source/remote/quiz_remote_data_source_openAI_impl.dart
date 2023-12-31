import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:quizzers/data/client/open_ai_client.dart';
import 'package:quizzers/data/data_source/remote/quiz_remote_data_source.dart';
import 'package:quizzers/data/model/question_dto.dart';
import 'package:quizzers/data/request/open_ai_client_request.dart';
import 'package:quizzers/util/string_extensions.dart';

@Injectable(as: QuizRemoteDataSource)
class QuizRemoteDataSourceOpenAIImpl implements QuizRemoteDataSource {
  QuizRemoteDataSourceOpenAIImpl({required this.client});

  final OpenAIClient client;

  @override
  Future<QuestionListDTO> getQuizzQuestions({
    required String category,
    required String difficulty,
    required int questionsCount,
    required int answersCount,
  }) async {
    final quizPrompt = QuizPrompt(
      category: category,
      difficulty: difficulty,
      questionsCount: questionsCount,
      answersCount: answersCount,
    );
    final response = await client.getJsonResponse(RequestBody(
      model: GptModel.gpt35Turbo,
      responseFormat: ResponseFormat(type: ResponseFormatType.json),
      messages: [
        Message(role: Role.system, content: quizPrompt.systemContent),
        Message(role: Role.user, content: quizPrompt.userContent),
      ],
    ));

    final firstChoice = response.choices.firstOrNull;
    if (firstChoice == null) {
      throw Exception('No choice available');
    }

    final jsonContent = jsonDecode(firstChoice.message.content);

    return QuestionListDTO.fromJson(jsonContent as Map<String, dynamic>);
  }
}

class QuizPrompt extends Prompt {
  final String category;
  final String difficulty;
  final int questionsCount;
  final int answersCount;

  static final _jsonTemplateFormat = QuestionListDTO(
    questions: [
      QuestionDTO(
        question: 'question content',
        answers: <String>[],
        correctAnswerIndex: 0,
      )
    ],
  ).toJson();

  static const _questionsCountParam = 'questionsCount';
  static const _answersCountParam = 'answersCount';
  static const _categoryParam = 'category';
  static const _difficultyParam = 'difficulty';

  static const _adoptPersonaPrompt = 'You are a quiz generator.';
  static final _jsonTemplatePrompt =
      'Output JSON format: $_jsonTemplateFormat.';

  static const _questionGenerationPrompt =
      'Generate {$_questionsCountParam} questions on {$_categoryParam} with {$_difficultyParam} difficulty. Each question have {$_answersCountParam} answers.';

  QuizPrompt({
    required this.category,
    required this.difficulty,
    required this.questionsCount,
    required this.answersCount,
  }) : super(
          systemContent: '$_adoptPersonaPrompt '
              '$_jsonTemplatePrompt',
          userContent: _questionGenerationPrompt.withParams({
            _questionsCountParam: questionsCount.toString(),
            _categoryParam: category,
            _difficultyParam: difficulty,
            _answersCountParam: answersCount.toString(),
          }),
        );
}

abstract class Prompt {
  final String systemContent;
  final String userContent;

  Prompt({required this.systemContent, required this.userContent});
}
