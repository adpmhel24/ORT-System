import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String? id;
  final String? username;
  final String? fullname;
  @MappableField(key: "user_type_code")
  final String? userTypeCode;
  @MappableField(key: "is_active")
  final bool? isActive;
  @MappableField(key: "is_superuser")
  final bool? isSuperUser;
  @MappableField(key: "is_admin")
  final bool? isAdmin;

  const AuthUser({
    this.id,
    this.username,
    this.fullname,
    this.userTypeCode,
    this.isActive,
    this.isSuperUser,
    this.isAdmin,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        fullname,
        userTypeCode,
        isActive,
        isSuperUser,
        isAdmin,
      ];
}
