import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/personnel_entity.dart';

part 'personnel_model.mapper.dart';

@MappableClass()
class PersonnelModel extends PersonnelEntity with PersonnelModelMappable {
  const PersonnelModel({
    super.id,
    super.fullName,
    super.licenseNumber,
    super.isActive,
    super.role,
  });
}
