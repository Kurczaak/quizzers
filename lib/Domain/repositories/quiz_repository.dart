import 'package:dartz/dartz.dart';
import 'package:quizzers/Domain/Entity/question.dart';
import 'package:quizzers/Domain/Failure/quizzer_failure.dart';

abstract class QuizRepository {
  Future<Either<QuizzerFailure, List<Question>>> getQuizzQuestions({
    required final String category,
    required final String difficulty,
    required final int numberOfQuestions,
  });
}
