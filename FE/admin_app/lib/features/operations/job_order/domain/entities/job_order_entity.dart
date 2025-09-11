import 'package:equatable/equatable.dart';

class JobOrderEntity extends Equatable {
  final int id;
  final String reference;
  final String bpName;
  final DateTime jobDate;
  final String? remarks;
  final String? contactNumber;
  final String jobDescription;
  final String status;
  final String pickupAddress;
  final String deliveryAddress;
  final double pickupLat;
  final double pickupLong;
  final double deliveryLat;
  final double deliveryLong;

  const JobOrderEntity({
    required this.id,
    required this.bpName,
    required this.jobDate,
    this.remarks,
    this.contactNumber,
    required this.jobDescription,
    required this.status,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.pickupLat,
    required this.pickupLong,
    required this.deliveryLat,
    required this.deliveryLong,
    required this.reference,
  });

  @override
  String toString() {
    return 'JobOrderEntity(id: $id, reference: $reference, bpName: $bpName, jobDate: $jobDate, status: $status)';
  }

  @override
  List<Object?> get props => [
        id,
        bpName,
        jobDate,
        remarks,
        jobDescription,
        status,
        pickupAddress,
        deliveryAddress,
        pickupLat,
        pickupLong,
        deliveryLat,
        deliveryLong,
        reference,
      ];
}
