import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/auth_user.dart';

part 'auth_user_model.mapper.dart';

@MappableClass()
class AuthUserModel extends AuthUser with AuthUserModelMappable {
  const AuthUserModel({
    super.id,
    super.fullname,
    super.isActive,
    super.isAdmin,
    super.isSuperUser,
    super.userTypeCode,
    super.username,
  });
}
