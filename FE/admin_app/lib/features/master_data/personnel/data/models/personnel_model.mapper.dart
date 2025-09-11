// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'personnel_model.dart';

class PersonnelModelMapper extends ClassMapperBase<PersonnelModel> {
  PersonnelModelMapper._();

  static PersonnelModelMapper? _instance;
  static PersonnelModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersonnelModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PersonnelModel';

  static int? _$id(PersonnelModel v) => v.id;
  static const Field<PersonnelModel, int> _f$id = Field('id', _$id, opt: true);
  static String? _$fullName(PersonnelModel v) => v.fullName;
  static const Field<PersonnelModel, String> _f$fullName =
      Field('fullName', _$fullName, opt: true);
  static String? _$licenseNumber(PersonnelModel v) => v.licenseNumber;
  static const Field<PersonnelModel, String> _f$licenseNumber =
      Field('licenseNumber', _$licenseNumber, opt: true);
  static bool? _$isActive(PersonnelModel v) => v.isActive;
  static const Field<PersonnelModel, bool> _f$isActive =
      Field('isActive', _$isActive, opt: true);
  static String? _$role(PersonnelModel v) => v.role;
  static const Field<PersonnelModel, String> _f$role =
      Field('role', _$role, opt: true);

  @override
  final MappableFields<PersonnelModel> fields = const {
    #id: _f$id,
    #fullName: _f$fullName,
    #licenseNumber: _f$licenseNumber,
    #isActive: _f$isActive,
    #role: _f$role,
  };

  static PersonnelModel _instantiate(DecodingData data) {
    return PersonnelModel(
        id: data.dec(_f$id),
        fullName: data.dec(_f$fullName),
        licenseNumber: data.dec(_f$licenseNumber),
        isActive: data.dec(_f$isActive),
        role: data.dec(_f$role));
  }

  @override
  final Function instantiate = _instantiate;

  static PersonnelModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PersonnelModel>(map);
  }

  static PersonnelModel fromJson(String json) {
    return ensureInitialized().decodeJson<PersonnelModel>(json);
  }
}

mixin PersonnelModelMappable {
  String toJson() {
    return PersonnelModelMapper.ensureInitialized()
        .encodeJson<PersonnelModel>(this as PersonnelModel);
  }

  Map<String, dynamic> toMap() {
    return PersonnelModelMapper.ensureInitialized()
        .encodeMap<PersonnelModel>(this as PersonnelModel);
  }

  PersonnelModelCopyWith<PersonnelModel, PersonnelModel, PersonnelModel>
      get copyWith => _PersonnelModelCopyWithImpl(
          this as PersonnelModel, $identity, $identity);
  @override
  String toString() {
    return PersonnelModelMapper.ensureInitialized()
        .stringifyValue(this as PersonnelModel);
  }

  @override
  bool operator ==(Object other) {
    return PersonnelModelMapper.ensureInitialized()
        .equalsValue(this as PersonnelModel, other);
  }

  @override
  int get hashCode {
    return PersonnelModelMapper.ensureInitialized()
        .hashValue(this as PersonnelModel);
  }
}

extension PersonnelModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PersonnelModel, $Out> {
  PersonnelModelCopyWith<$R, PersonnelModel, $Out> get $asPersonnelModel =>
      $base.as((v, t, t2) => _PersonnelModelCopyWithImpl(v, t, t2));
}

abstract class PersonnelModelCopyWith<$R, $In extends PersonnelModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? fullName,
      String? licenseNumber,
      bool? isActive,
      String? role});
  PersonnelModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PersonnelModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PersonnelModel, $Out>
    implements PersonnelModelCopyWith<$R, PersonnelModel, $Out> {
  _PersonnelModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PersonnelModel> $mapper =
      PersonnelModelMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? fullName = $none,
          Object? licenseNumber = $none,
          Object? isActive = $none,
          Object? role = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (fullName != $none) #fullName: fullName,
        if (licenseNumber != $none) #licenseNumber: licenseNumber,
        if (isActive != $none) #isActive: isActive,
        if (role != $none) #role: role
      }));
  @override
  PersonnelModel $make(CopyWithData data) => PersonnelModel(
      id: data.get(#id, or: $value.id),
      fullName: data.get(#fullName, or: $value.fullName),
      licenseNumber: data.get(#licenseNumber, or: $value.licenseNumber),
      isActive: data.get(#isActive, or: $value.isActive),
      role: data.get(#role, or: $value.role));

  @override
  PersonnelModelCopyWith<$R2, PersonnelModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PersonnelModelCopyWithImpl($value, $cast, t);
}
