// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'log_empl_position_model.dart';

class LogEmplPositionModelMapper extends ClassMapperBase<LogEmplPositionModel> {
  LogEmplPositionModelMapper._();

  static LogEmplPositionModelMapper? _instance;
  static LogEmplPositionModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LogEmplPositionModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LogEmplPositionModel';

  static int _$id(LogEmplPositionModel v) => v.id;
  static const Field<LogEmplPositionModel, int> _f$id = Field('id', _$id);
  static String _$code(LogEmplPositionModel v) => v.code;
  static const Field<LogEmplPositionModel, String> _f$code =
      Field('code', _$code);
  static String _$description(LogEmplPositionModel v) => v.description;
  static const Field<LogEmplPositionModel, String> _f$description =
      Field('description', _$description);
  static Map<String, dynamic> _$createdBy(LogEmplPositionModel v) =>
      v.createdBy;
  static const Field<LogEmplPositionModel, Map<String, dynamic>> _f$createdBy =
      Field('createdBy', _$createdBy);

  @override
  final MappableFields<LogEmplPositionModel> fields = const {
    #id: _f$id,
    #code: _f$code,
    #description: _f$description,
    #createdBy: _f$createdBy,
  };

  static LogEmplPositionModel _instantiate(DecodingData data) {
    return LogEmplPositionModel(
        id: data.dec(_f$id),
        code: data.dec(_f$code),
        description: data.dec(_f$description),
        createdBy: data.dec(_f$createdBy));
  }

  @override
  final Function instantiate = _instantiate;

  static LogEmplPositionModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LogEmplPositionModel>(map);
  }

  static LogEmplPositionModel fromJson(String json) {
    return ensureInitialized().decodeJson<LogEmplPositionModel>(json);
  }
}

mixin LogEmplPositionModelMappable {
  String toJson() {
    return LogEmplPositionModelMapper.ensureInitialized()
        .encodeJson<LogEmplPositionModel>(this as LogEmplPositionModel);
  }

  Map<String, dynamic> toMap() {
    return LogEmplPositionModelMapper.ensureInitialized()
        .encodeMap<LogEmplPositionModel>(this as LogEmplPositionModel);
  }

  LogEmplPositionModelCopyWith<LogEmplPositionModel, LogEmplPositionModel,
          LogEmplPositionModel>
      get copyWith => _LogEmplPositionModelCopyWithImpl(
          this as LogEmplPositionModel, $identity, $identity);
  @override
  String toString() {
    return LogEmplPositionModelMapper.ensureInitialized()
        .stringifyValue(this as LogEmplPositionModel);
  }

  @override
  bool operator ==(Object other) {
    return LogEmplPositionModelMapper.ensureInitialized()
        .equalsValue(this as LogEmplPositionModel, other);
  }

  @override
  int get hashCode {
    return LogEmplPositionModelMapper.ensureInitialized()
        .hashValue(this as LogEmplPositionModel);
  }
}

extension LogEmplPositionModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LogEmplPositionModel, $Out> {
  LogEmplPositionModelCopyWith<$R, LogEmplPositionModel, $Out>
      get $asLogEmplPositionModel =>
          $base.as((v, t, t2) => _LogEmplPositionModelCopyWithImpl(v, t, t2));
}

abstract class LogEmplPositionModelCopyWith<
    $R,
    $In extends LogEmplPositionModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get createdBy;
  $R call(
      {int? id,
      String? code,
      String? description,
      Map<String, dynamic>? createdBy});
  LogEmplPositionModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _LogEmplPositionModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LogEmplPositionModel, $Out>
    implements LogEmplPositionModelCopyWith<$R, LogEmplPositionModel, $Out> {
  _LogEmplPositionModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LogEmplPositionModel> $mapper =
      LogEmplPositionModelMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get createdBy => MapCopyWith($value.createdBy,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(createdBy: v));
  @override
  $R call(
          {int? id,
          String? code,
          String? description,
          Map<String, dynamic>? createdBy}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (code != null) #code: code,
        if (description != null) #description: description,
        if (createdBy != null) #createdBy: createdBy
      }));
  @override
  LogEmplPositionModel $make(CopyWithData data) => LogEmplPositionModel(
      id: data.get(#id, or: $value.id),
      code: data.get(#code, or: $value.code),
      description: data.get(#description, or: $value.description),
      createdBy: data.get(#createdBy, or: $value.createdBy));

  @override
  LogEmplPositionModelCopyWith<$R2, LogEmplPositionModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _LogEmplPositionModelCopyWithImpl($value, $cast, t);
}
