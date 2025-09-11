// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'employee_position_model.dart';

class EmployeePositionModelMapper
    extends ClassMapperBase<EmployeePositionModel> {
  EmployeePositionModelMapper._();

  static EmployeePositionModelMapper? _instance;
  static EmployeePositionModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmployeePositionModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EmployeePositionModel';

  static String _$code(EmployeePositionModel v) => v.code;
  static const Field<EmployeePositionModel, String> _f$code =
      Field('code', _$code);
  static String _$description(EmployeePositionModel v) => v.description;
  static const Field<EmployeePositionModel, String> _f$description =
      Field('description', _$description);
  static bool _$isActive(EmployeePositionModel v) => v.isActive;
  static const Field<EmployeePositionModel, bool> _f$isActive =
      Field('isActive', _$isActive, opt: true, def: true);

  @override
  final MappableFields<EmployeePositionModel> fields = const {
    #code: _f$code,
    #description: _f$description,
    #isActive: _f$isActive,
  };

  static EmployeePositionModel _instantiate(DecodingData data) {
    return EmployeePositionModel(
        code: data.dec(_f$code),
        description: data.dec(_f$description),
        isActive: data.dec(_f$isActive));
  }

  @override
  final Function instantiate = _instantiate;

  static EmployeePositionModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EmployeePositionModel>(map);
  }

  static EmployeePositionModel fromJson(String json) {
    return ensureInitialized().decodeJson<EmployeePositionModel>(json);
  }
}

mixin EmployeePositionModelMappable {
  String toJson() {
    return EmployeePositionModelMapper.ensureInitialized()
        .encodeJson<EmployeePositionModel>(this as EmployeePositionModel);
  }

  Map<String, dynamic> toMap() {
    return EmployeePositionModelMapper.ensureInitialized()
        .encodeMap<EmployeePositionModel>(this as EmployeePositionModel);
  }

  EmployeePositionModelCopyWith<EmployeePositionModel, EmployeePositionModel,
          EmployeePositionModel>
      get copyWith => _EmployeePositionModelCopyWithImpl(
          this as EmployeePositionModel, $identity, $identity);
  @override
  String toString() {
    return EmployeePositionModelMapper.ensureInitialized()
        .stringifyValue(this as EmployeePositionModel);
  }

  @override
  bool operator ==(Object other) {
    return EmployeePositionModelMapper.ensureInitialized()
        .equalsValue(this as EmployeePositionModel, other);
  }

  @override
  int get hashCode {
    return EmployeePositionModelMapper.ensureInitialized()
        .hashValue(this as EmployeePositionModel);
  }
}

extension EmployeePositionModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EmployeePositionModel, $Out> {
  EmployeePositionModelCopyWith<$R, EmployeePositionModel, $Out>
      get $asEmployeePositionModel =>
          $base.as((v, t, t2) => _EmployeePositionModelCopyWithImpl(v, t, t2));
}

abstract class EmployeePositionModelCopyWith<
    $R,
    $In extends EmployeePositionModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? code, String? description, bool? isActive});
  EmployeePositionModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _EmployeePositionModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EmployeePositionModel, $Out>
    implements EmployeePositionModelCopyWith<$R, EmployeePositionModel, $Out> {
  _EmployeePositionModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EmployeePositionModel> $mapper =
      EmployeePositionModelMapper.ensureInitialized();
  @override
  $R call({String? code, String? description, bool? isActive}) =>
      $apply(FieldCopyWithData({
        if (code != null) #code: code,
        if (description != null) #description: description,
        if (isActive != null) #isActive: isActive
      }));
  @override
  EmployeePositionModel $make(CopyWithData data) => EmployeePositionModel(
      code: data.get(#code, or: $value.code),
      description: data.get(#description, or: $value.description),
      isActive: data.get(#isActive, or: $value.isActive));

  @override
  EmployeePositionModelCopyWith<$R2, EmployeePositionModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _EmployeePositionModelCopyWithImpl($value, $cast, t);
}
