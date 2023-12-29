import 'package:json_annotation/json_annotation.dart';

part 'open_ai_client_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OpenAIClientResponse {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choice> choices;
  final Usage usage;
  final String systemFingerprint;

  OpenAIClientResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    required this.systemFingerprint,
  });

  factory OpenAIClientResponse.fromJson(Map<String, dynamic> json) =>
      _$OpenAIClientResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OpenAIClientResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Choice {
  final int index;
  final Message message;
  final dynamic logprobs; // Keeping dynamic as the type is null in the example
  final String finishReason;

  Choice({
    required this.index,
    required this.message,
    this.logprobs,
    required this.finishReason,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Message {
  final String role;
  final String content;

  Message({required this.role, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => _$UsageFromJson(json);
  Map<String, dynamic> toJson() => _$UsageToJson(this);
}
