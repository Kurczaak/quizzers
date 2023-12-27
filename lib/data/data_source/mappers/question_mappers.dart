import 'package:quizzers/Domain/Entity/question.dart';
import 'package:quizzers/data/model/question_dto.dart';

extension QuestionDTOListMapperX on QuestionListDTO {
  List<Question> toDomain() => questions.map((e) => e.toDomain()).toList();
}

extension QuestionDTOMapperX on QuestionDTO {
  Question toDomain() {
    final domainAnswers = answers.map((e) => Answer(answer: e)).toList();

    return Question(
      question: question,
      answers: domainAnswers,
      correctAnswerIndex: correctAnswerIndex,
    );
  }
}
