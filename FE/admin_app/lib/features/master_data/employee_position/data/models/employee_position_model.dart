import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/employee_position_entity.dart';

part 'employee_position_model.mapper.dart';

@MappableClass()
class EmployeePositionModel extends EmployeePositionEntity
    with EmployeePositionModelMappable {
  static const List<String> headers = [
    'code',
    'description',
    'isActive',
  ];

  const EmployeePositionModel({
    required super.code,
    required super.description,
    super.isActive,
  });
}
