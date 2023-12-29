import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:quizzers/data/client/open_ai_client.dart';

@module
abstract class RetrofitInjectableModule {
  final apiKey = dotenv.env['API_KEY'];
  @LazySingleton()
  Dio get dio => Dio(
        BaseOptions(
          headers: {'authorization': 'Bearer $apiKey'},
          connectTimeout: const Duration(seconds: 30), // TODO extract
          receiveTimeout: const Duration(seconds: 30), // TODO extract
        ),
      );
  OpenAIClient getService(Dio client) => OpenAIClient(
        client,
      );
}
