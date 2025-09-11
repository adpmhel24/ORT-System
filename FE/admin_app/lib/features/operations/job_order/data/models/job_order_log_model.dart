import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/job_order_log_entity.dart';

part 'job_order_log_model.mapper.dart';

@MappableClass()
class JobOrderLogModel extends JobOrderLogEntity with JobOrderLogModelMappable {
  static const List<String> headers = [
    'id',
    'notes',
    'createdAt',
    'createdBy',
  ];

  const JobOrderLogModel(
      {required super.id,
      required super.notes,
      required super.createdAt,
      required super.createdBy});
}
