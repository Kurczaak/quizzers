import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:quizzers/data/client/open_ai_client.dart';

@module
abstract class RetrofitInjectableModule {
  @LazySingleton()
  Dio get dio => Dio();
  OpenAIClient getService(Dio client, @factoryParam String url) => OpenAIClient(
        client,
        baseUrl: 'https://api.openai.com/',
      ); // TODO extract to config
}
