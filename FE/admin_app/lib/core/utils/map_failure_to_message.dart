import 'package:admin_app/core/errors/failures.dart';

String mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure) {
    return failure.message;
  } else if (failure is FrontEndFailure) {
    return failure.message;
  } else {
    return "Unexpected error";
  }
}
