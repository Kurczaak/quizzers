import 'package:dartz/dartz.dart';
import 'package:quizzers/Domain/Entity/question.dart';
import 'package:quizzers/Domain/Failure/quizzer_failure.dart';

class GetQuestionsUseCase {
  Future<Either<QuizzerFailure, List<Question>>> getQuestions(
    final String category,
    final String difficulty,
    final int numberOfQuestions,
  ) async {
    // TODO : Implement the getQuestions method
    return const Left(QuizzerFailure.unknownError());
  }
}
