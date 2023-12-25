import 'package:quizzers/Domain/Entity/question.dart';
import 'package:quizzers/data/model/question_dto.dart';

extension QuestionDTOListMapperX on List<QuestionDTO> {
  List<Question> toDomain() => map((e) => e.toDomain()).toList();
}

extension QuestionDTOMapperX on QuestionDTO {
  Question toDomain() {
    final domainAnswers = answers.map((e) => Answer(answer: e)).toList();
    final correctAnswer = correctAnswerIndex > domainAnswers.length - 1
        ? domainAnswers.first
        : domainAnswers[correctAnswerIndex];
    return Question(
      question: question,
      answers: domainAnswers,
      correctAnswer: correctAnswer,
    );
  }
}
