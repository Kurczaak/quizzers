import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:quizzers/Domain/Entity/question.dart';
import 'package:quizzers/Domain/Failure/quizzer_failure.dart';
import 'package:quizzers/data/data_source/mappers/question_mappers.dart';
import 'package:quizzers/data/data_source/remote/quiz_remote_data_source.dart';
import 'package:quizzers/domain/repositories/quiz_repository.dart';

@Injectable(as: QuizRepository)
class QuizzRepositoryGPTImpl implements QuizRepository {
  QuizzRepositoryGPTImpl({required QuizRemoteDataSource quizRemoteDataSource})
      : _quizRemoteDataSource = quizRemoteDataSource;

  final QuizRemoteDataSource _quizRemoteDataSource;

  @override
  Future<Either<QuizzerFailure, List<Question>>> getQuizzQuestions({
    required String category,
    required String difficulty,
    required int questionsCount,
    required int answersCount,
  }) async {
    try {
      final result = await _quizRemoteDataSource.getQuizzQuestions(
          category: category,
          difficulty: difficulty,
          questionsCount: questionsCount,
          answersCount: answersCount);
      return Right(result.toDomain());
    } catch (e) {
      // TODO implement exception handling
      return const Left(QuizzerFailure.unknownError());
    }
  }
}
