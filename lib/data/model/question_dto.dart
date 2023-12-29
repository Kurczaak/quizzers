import 'package:json_annotation/json_annotation.dart';

part 'question_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionListDTO {
  final List<QuestionDTO> questions;

  QuestionListDTO({required this.questions});

  factory QuestionListDTO.fromJson(Map<String, dynamic> json) =>
      _$QuestionListDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionListDTOToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuestionDTO {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  QuestionDTO({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
  });

  factory QuestionDTO.fromJson(Map<String, dynamic> json) =>
      _$QuestionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDTOToJson(this);
}
