import 'package:freezed_annotation/freezed_annotation.dart';

part 'quizzer_failure.freezed.dart';

@freezed
abstract class QuizzerFailure with _$QuizzerFailure {
  const factory QuizzerFailure.unknownError() = UnknownError;
}
