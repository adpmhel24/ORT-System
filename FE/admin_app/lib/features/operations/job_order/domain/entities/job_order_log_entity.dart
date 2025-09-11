import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

class JobOrderLogEntity extends Equatable {
  final int id;
  final String notes;
  final DateTime createdAt;
  @MappableField(key: "created_by")
  final int createdBy;

  const JobOrderLogEntity(
      {required this.id,
      required this.notes,
      required this.createdAt,
      required this.createdBy});

  @override
  List<Object?> get props => [id, notes, createdAt, createdBy];
}
