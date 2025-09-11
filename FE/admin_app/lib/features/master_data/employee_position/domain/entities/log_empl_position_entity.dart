import 'package:equatable/equatable.dart';

class LogEmplPositionEntity extends Equatable {
  final int id;
  final String code;
  final String description;
  final Map<String, dynamic> createdBy;

  const LogEmplPositionEntity({
    required this.id,
    required this.code,
    required this.description,
    required this.createdBy,
  });

  @override
  List<Object?> get props => [id, code, description, createdBy];
}
