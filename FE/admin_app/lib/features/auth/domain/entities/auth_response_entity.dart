import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

class AuthResponseEntity extends Equatable {
  @MappableField(key: "access_token")
  final String accessToken;
  @MappableField(key: "token_type")
  final String tokenType;

  const AuthResponseEntity(
      {required this.accessToken, required this.tokenType});

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
      ];
}
