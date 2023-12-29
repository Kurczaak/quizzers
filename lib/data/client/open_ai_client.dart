import 'package:dio/dio.dart';
import 'package:quizzers/data/request/open_ai_client_request.dart';
import 'package:quizzers/data/response/open_ai_client_response.dart';
import 'package:retrofit/retrofit.dart';

part 'open_ai_client.g.dart';

@RestApi()
abstract class OpenAIClient {
  factory OpenAIClient(Dio dio) = _OpenAIClient;

  @POST('https://api.openai.com/v1/chat/completions')
  Future<OpenAIClientResponse> getJsonResponse(@Body() RequestBody body);
}
