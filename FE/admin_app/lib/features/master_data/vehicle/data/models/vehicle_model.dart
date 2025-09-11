import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/vehicle_entity.dart';

part 'vehicle_model.mapper.dart';

@MappableClass()
class VehicleModel extends VehicleEntity with VehicleModelMappable {
  static const List<String> headers = [
    'id',
    'plateNumber',
    'yearModel',
    'maker',
    'category',
    'orNumber',
    'crNumber',
    'fuelLevel',
    'currentMileage',
    'minDiesel',
    'withLoadConsumption',
    'withoutLoadConsumption',
    'status',
  ];

  const VehicleModel({
    super.id,
    super.plateNumber,
    super.yearModel,
    super.maker,
    super.category,
    super.orNumber,
    super.crNumber,
    super.fuelLevel,
    super.currentMileage,
    super.minDiesel,
    super.withLoadConsumption,
    super.withoutLoadConsumption,
    super.status,
  });
}
