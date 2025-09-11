import 'package:equatable/equatable.dart';

class PersonnelEntity extends Equatable {
  final int? id;
  final String? fullName;
  final String? licenseNumber;
  final bool? isActive;
  final String? role;

  const PersonnelEntity({
    this.id,
    this.fullName,
    this.licenseNumber,
    this.isActive,
    this.role,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        licenseNumber,
        isActive,
        role,
      ];
}
