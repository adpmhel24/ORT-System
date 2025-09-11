import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/job_order_entity.dart';
import 'job_order_log_model.dart';

part 'job_order_model.mapper.dart';

@MappableClass()
class JobOrderModel extends JobOrderEntity with JobOrderModelMappable {
  static const List<String> headers = [
    'id',
    'reference',
    'bpName',
    'contactNumber',
    'jobDate',
    'remarks',
    'jobDescription',
    'status',
    'pickupAddress',
    'deliveryAddress',
    'pickupLat',
    'pickupLong',
    'deliveryLat',
    'deliveryLong',
  ];

  final List<JobOrderLogModel> logNotes;

  const JobOrderModel({
    required super.id,
    required super.reference,
    required super.bpName,
    required super.jobDate,
    super.remarks,
    super.contactNumber,
    required super.jobDescription,
    required super.status,
    required super.pickupAddress,
    required super.deliveryAddress,
    required super.pickupLat,
    required super.pickupLong,
    required super.deliveryLat,
    required super.deliveryLong,
    this.logNotes = const [],
  });
}
