import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/log_empl_position_entity.dart';

part 'log_empl_position_model.mapper.dart';

@MappableClass()
class LogEmplPositionModel extends LogEmplPositionEntity
    with LogEmplPositionModelMappable {
  static const List<String> headers = [
    'id',
    'code',
    'description',
  ];

  const LogEmplPositionModel({
    required super.id,
    required super.code,
    required super.description,
    required super.createdBy,
  });
}
