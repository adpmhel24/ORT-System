import 'package:equatable/equatable.dart';

class VehicleEntity extends Equatable {
  final int? id;
  final String? plateNumber;
  final int? yearModel;
  final String? maker;
  final String? category;
  final String? orNumber;
  final String? crNumber;
  final double? fuelLevel;
  final int? currentMileage;
  final double? minDiesel;
  final double? withLoadConsumption;
  final double? withoutLoadConsumption;
  final String? status;

  const VehicleEntity({
    this.id,
    this.plateNumber,
    this.yearModel,
    this.maker,
    this.category,
    this.orNumber,
    this.crNumber,
    this.fuelLevel,
    this.currentMileage,
    this.minDiesel,
    this.withLoadConsumption,
    this.withoutLoadConsumption,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
        plateNumber,
        yearModel,
        maker,
        category,
        orNumber,
        crNumber,
        fuelLevel,
        currentMileage,
        minDiesel,
        withLoadConsumption,
        withoutLoadConsumption,
        status,
      ];
}
