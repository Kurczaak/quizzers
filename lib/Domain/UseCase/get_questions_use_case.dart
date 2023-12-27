import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quizzers/Domain/Entity/question.dart';
import 'package:quizzers/Domain/Failure/quizzer_failure.dart';
import 'package:quizzers/domain/repositories/quiz_repository.dart';

@Injectable()
class GetQuestionsUseCase {
  final QuizRepository _quizRepository;

  GetQuestionsUseCase({required QuizRepository quizRepository})
      : _quizRepository = quizRepository;
  Future<Either<QuizzerFailure, List<Question>>> getQuestions(
    final String category,
    final String difficulty,
    final int numberOfQuestions,
  ) =>
      _quizRepository.getQuizzQuestions(
        category: category,
        difficulty: difficulty,
        numberOfQuestions: numberOfQuestions,
      );
}
