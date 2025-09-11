// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vehicle_log_model.dart';

class VehicleLogModelMapper extends ClassMapperBase<VehicleLogModel> {
  VehicleLogModelMapper._();

  static VehicleLogModelMapper? _instance;
  static VehicleLogModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VehicleLogModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VehicleLogModel';

  static int? _$id(VehicleLogModel v) => v.id;
  static const Field<VehicleLogModel, int> _f$id = Field('id', _$id, opt: true);
  static int? _$vehicleId(VehicleLogModel v) => v.vehicleId;
  static const Field<VehicleLogModel, int> _f$vehicleId =
      Field('vehicleId', _$vehicleId, opt: true);
  static String? _$note(VehicleLogModel v) => v.note;
  static const Field<VehicleLogModel, String> _f$note =
      Field('note', _$note, opt: true);
  static DateTime? _$createdAt(VehicleLogModel v) => v.createdAt;
  static const Field<VehicleLogModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, key: r'created_at', opt: true);
  static int? _$createdBy(VehicleLogModel v) => v.createdBy;
  static const Field<VehicleLogModel, int> _f$createdBy =
      Field('createdBy', _$createdBy, key: r'created_by', opt: true);

  @override
  final MappableFields<VehicleLogModel> fields = const {
    #id: _f$id,
    #vehicleId: _f$vehicleId,
    #note: _f$note,
    #createdAt: _f$createdAt,
    #createdBy: _f$createdBy,
  };

  static VehicleLogModel _instantiate(DecodingData data) {
    return VehicleLogModel(
        id: data.dec(_f$id),
        vehicleId: data.dec(_f$vehicleId),
        note: data.dec(_f$note),
        createdAt: data.dec(_f$createdAt),
        createdBy: data.dec(_f$createdBy));
  }

  @override
  final Function instantiate = _instantiate;

  static VehicleLogModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VehicleLogModel>(map);
  }

  static VehicleLogModel fromJson(String json) {
    return ensureInitialized().decodeJson<VehicleLogModel>(json);
  }
}

mixin VehicleLogModelMappable {
  String toJson() {
    return VehicleLogModelMapper.ensureInitialized()
        .encodeJson<VehicleLogModel>(this as VehicleLogModel);
  }

  Map<String, dynamic> toMap() {
    return VehicleLogModelMapper.ensureInitialized()
        .encodeMap<VehicleLogModel>(this as VehicleLogModel);
  }

  VehicleLogModelCopyWith<VehicleLogModel, VehicleLogModel, VehicleLogModel>
      get copyWith => _VehicleLogModelCopyWithImpl(
          this as VehicleLogModel, $identity, $identity);
  @override
  String toString() {
    return VehicleLogModelMapper.ensureInitialized()
        .stringifyValue(this as VehicleLogModel);
  }

  @override
  bool operator ==(Object other) {
    return VehicleLogModelMapper.ensureInitialized()
        .equalsValue(this as VehicleLogModel, other);
  }

  @override
  int get hashCode {
    return VehicleLogModelMapper.ensureInitialized()
        .hashValue(this as VehicleLogModel);
  }
}

extension VehicleLogModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VehicleLogModel, $Out> {
  VehicleLogModelCopyWith<$R, VehicleLogModel, $Out> get $asVehicleLogModel =>
      $base.as((v, t, t2) => _VehicleLogModelCopyWithImpl(v, t, t2));
}

abstract class VehicleLogModelCopyWith<$R, $In extends VehicleLogModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      int? vehicleId,
      String? note,
      DateTime? createdAt,
      int? createdBy});
  VehicleLogModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _VehicleLogModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VehicleLogModel, $Out>
    implements VehicleLogModelCopyWith<$R, VehicleLogModel, $Out> {
  _VehicleLogModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VehicleLogModel> $mapper =
      VehicleLogModelMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? vehicleId = $none,
          Object? note = $none,
          Object? createdAt = $none,
          Object? createdBy = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (vehicleId != $none) #vehicleId: vehicleId,
        if (note != $none) #note: note,
        if (createdAt != $none) #createdAt: createdAt,
        if (createdBy != $none) #createdBy: createdBy
      }));
  @override
  VehicleLogModel $make(CopyWithData data) => VehicleLogModel(
      id: data.get(#id, or: $value.id),
      vehicleId: data.get(#vehicleId, or: $value.vehicleId),
      note: data.get(#note, or: $value.note),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      createdBy: data.get(#createdBy, or: $value.createdBy));

  @override
  VehicleLogModelCopyWith<$R2, VehicleLogModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _VehicleLogModelCopyWithImpl($value, $cast, t);
}
