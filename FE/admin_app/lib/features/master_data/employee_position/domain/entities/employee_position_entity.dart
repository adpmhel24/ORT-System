import 'package:equatable/equatable.dart';

class EmployeePositionEntity extends Equatable {
  final String code;
  final String description;
  final bool isActive;
  const EmployeePositionEntity({
    required this.code,
    required this.description,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [code, description, isActive];
}
