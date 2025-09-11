import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/bp_entity.dart';

part 'bp_model.mapper.dart';

@MappableClass()
class BusinessPartnerModel extends BusinessPartnerEntity
    with BusinessPartnerModelMappable {
  static const List<String> headers = [
    'id',
    'bpName',
    'contactPerson',
    'bpType',
    'address',
    'contactNumber',
    'lat',
    'long',
    'isActive',
  ];

  const BusinessPartnerModel({
    required super.id,
    required super.bpName,
    required super.contactPerson,
    required super.bpType,
    super.address,
    super.contactNumber,
    super.lat,
    super.long,
    super.isActive,
  });
}
