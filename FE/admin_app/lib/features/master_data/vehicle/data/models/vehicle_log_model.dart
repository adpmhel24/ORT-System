import 'package:admin_app/features/master_data/vehicle/domain/entities/vehicle_log_entity.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'vehicle_log_model.mapper.dart';

@MappableClass()
class VehicleLogModel extends VehicleLogEntity with VehicleLogModelMappable {
  static const List<String> headers = [
    'id',
    'vehicleId',
    'note',
    'createdAt',
    'createdBy',
  ];

  const VehicleLogModel({
    super.id,
    super.vehicleId,
    super.note,
    super.createdAt,
    super.createdBy,
  });
}
