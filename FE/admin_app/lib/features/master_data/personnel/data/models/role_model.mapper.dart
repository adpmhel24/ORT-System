// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'role_model.dart';

class PersonnelRoleMapper extends EnumMapper<PersonnelRole> {
  PersonnelRoleMapper._();

  static PersonnelRoleMapper? _instance;
  static PersonnelRoleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersonnelRoleMapper._());
    }
    return _instance!;
  }

  static PersonnelRole fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PersonnelRole decode(dynamic value) {
    switch (value) {
      case 'driver':
        return PersonnelRole.driver;
      case 'helper':
        return PersonnelRole.helper;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PersonnelRole self) {
    switch (self) {
      case PersonnelRole.driver:
        return 'driver';
      case PersonnelRole.helper:
        return 'helper';
    }
  }
}

extension PersonnelRoleMapperExtension on PersonnelRole {
  String toValue() {
    PersonnelRoleMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PersonnelRole>(this) as String;
  }
}
