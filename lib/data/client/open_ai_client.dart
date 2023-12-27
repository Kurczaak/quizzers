import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quizzers/data/response/open_ai_client_response.dart';
import 'package:retrofit/retrofit.dart';

part 'open_ai_client.g.dart';

@RestApi()
abstract class OpenAIClient {
  factory OpenAIClient(Dio dio, {String baseUrl}) = _OpenAIClient;

  // GOOD
  @GET('/v1/chat/completions')
  Future<OpenAIClientResponse> getJsonResponse(@Body() RequestBody body);
}

enum GptModel {
  @JsonValue("gpt-4-vision-preview")
  gpt4Turbo('gpt-4-vision-preview'),
  @JsonValue("gpt-4")
  gpt4('gpt-4'),
  @JsonValue("gpt-3.5-turbo-1106")
  gpt35Turbo('gpt-3.5-turbo-1106');

  final String name;
  const GptModel(this.name);

  String toJson() => name;
}

enum ResponseFormatType {
  @JsonValue("json_object")
  json("json_object");

  final String type;
  const ResponseFormatType(this.type);
}

enum Role {
  @JsonValue("user")
  user('user'),
  @JsonValue("system")
  system('system');

  final String name;
  const Role(this.name);

  String toJson() => name;
}

@JsonSerializable()
class ResponseFormat {
  final ResponseFormatType type;

  ResponseFormat({required this.type});

  factory ResponseFormat.fromJson(Map<String, dynamic> json) =>
      _$ResponseFormatFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseFormatToJson(this);
}

@JsonSerializable()
class Message {
  final Role role;
  final String content;

  Message({required this.role, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class RequestBody {
  final GptModel model;
  final ResponseFormat responseFormat;
  final List<Message> messages;

  RequestBody({
    required this.model,
    required this.responseFormat,
    required this.messages,
  });

  factory RequestBody.fromMessages({
    required GptModel model,
    required ResponseFormat responseFormat,
    required List<Message> messages,
    required String systemMessage,
    required String userMessage,
  }) =>
      RequestBody(
        model: model,
        responseFormat: ResponseFormat(type: ResponseFormatType.json),
        messages: [
          Message(
            role: Role.system,
            content: systemMessage,
          ),
          Message(
            role: Role.user,
            content: userMessage,
          ),
        ],
      );

  factory RequestBody.fromJson(Map<String, dynamic> json) =>
      _$RequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RequestBodyToJson(this);
}
