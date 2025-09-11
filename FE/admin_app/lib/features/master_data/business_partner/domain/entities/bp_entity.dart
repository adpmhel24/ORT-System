import 'package:equatable/equatable.dart';

class BusinessPartnerEntity extends Equatable {
  final int id;
  final String bpName;
  final String contactPerson;
  final String bpType;
  final String? address;
  final String? contactNumber;

  final double? lat;
  final double? long;
  final bool isActive;

  const BusinessPartnerEntity({
    required this.id,
    required this.bpName,
    required this.contactPerson,
    required this.bpType,
    this.address,
    this.contactNumber,
    this.lat,
    this.long,
    this.isActive = true,
  });

  @override
  String toString() {
    return 'BusinessPartnerEntity(id: $id, name: $bpName, address: $address, contactNumber: $contactNumber) extends Equatable';
  }

  @override
  List<Object?> get props => [
        id,
        bpName,
        contactPerson,
        bpType,
        address,
        contactNumber,
        lat,
        long,
        isActive,
      ];
}
