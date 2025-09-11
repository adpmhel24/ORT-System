import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/auth_response_entity.dart';
import 'auth_user_model.dart';

part 'auth_response_model.mapper.dart';

@MappableClass()
class AuthResponseModel extends AuthResponseEntity
    with AuthResponseModelMappable {
  final AuthUserModel data;

  const AuthResponseModel({
    required this.data,
    required super.accessToken,
    required super.tokenType,
  });
}
