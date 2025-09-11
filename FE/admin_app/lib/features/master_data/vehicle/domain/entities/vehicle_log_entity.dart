import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

class VehicleLogEntity extends Equatable {
  final int? id;
  final int? vehicleId;
  final String? note;
  @MappableField(key: "created_at")
  final DateTime? createdAt;
  @MappableField(key: "created_by")
  final int? createdBy;

  const VehicleLogEntity({
    this.id,
    this.vehicleId,
    this.note,
    this.createdAt,
    this.createdBy,
  });

  @override
  List<Object?> get props => [
        id,
        vehicleId,
        note,
        createdAt,
        createdBy,
      ];
}
