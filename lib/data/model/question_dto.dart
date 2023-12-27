import 'package:json_annotation/json_annotation.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionListDTO {
  final List<QuestionDTO> questions;

  QuestionListDTO({required this.questions});

  factory QuestionListDTO.fromJson(Map<String, dynamic> json) =>
      _$QuestionListDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionListDTOToJson(this);
}

@JsonSerializable()
class QuestionDTO {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  QuestionDTO(this.question, this.answers, this.correctAnswerIndex);

  factory QuestionDTO.fromJson(Map<String, dynamic> json) =>
      _$QuestionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDTOToJson(this);
}
