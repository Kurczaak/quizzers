import 'package:quizzers/data/model/question_dto.dart';

abstract class QuizRemoteDataSource {
  Future<List<QuestionDTO>> getQuizzQuestions({
    required final String category,
    required final String difficulty,
    required final int numberOfQuestions,
  });
}
