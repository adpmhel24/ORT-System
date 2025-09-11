// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vehicle_model.dart';

class VehicleModelMapper extends ClassMapperBase<VehicleModel> {
  VehicleModelMapper._();

  static VehicleModelMapper? _instance;
  static VehicleModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VehicleModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VehicleModel';

  static int? _$id(VehicleModel v) => v.id;
  static const Field<VehicleModel, int> _f$id = Field('id', _$id, opt: true);
  static String? _$plateNumber(VehicleModel v) => v.plateNumber;
  static const Field<VehicleModel, String> _f$plateNumber =
      Field('plateNumber', _$plateNumber, opt: true);
  static int? _$yearModel(VehicleModel v) => v.yearModel;
  static const Field<VehicleModel, int> _f$yearModel =
      Field('yearModel', _$yearModel, opt: true);
  static String? _$maker(VehicleModel v) => v.maker;
  static const Field<VehicleModel, String> _f$maker =
      Field('maker', _$maker, opt: true);
  static String? _$category(VehicleModel v) => v.category;
  static const Field<VehicleModel, String> _f$category =
      Field('category', _$category, opt: true);
  static String? _$orNumber(VehicleModel v) => v.orNumber;
  static const Field<VehicleModel, String> _f$orNumber =
      Field('orNumber', _$orNumber, opt: true);
  static String? _$crNumber(VehicleModel v) => v.crNumber;
  static const Field<VehicleModel, String> _f$crNumber =
      Field('crNumber', _$crNumber, opt: true);
  static double? _$fuelLevel(VehicleModel v) => v.fuelLevel;
  static const Field<VehicleModel, double> _f$fuelLevel =
      Field('fuelLevel', _$fuelLevel, opt: true);
  static int? _$currentMileage(VehicleModel v) => v.currentMileage;
  static const Field<VehicleModel, int> _f$currentMileage =
      Field('currentMileage', _$currentMileage, opt: true);
  static double? _$minDiesel(VehicleModel v) => v.minDiesel;
  static const Field<VehicleModel, double> _f$minDiesel =
      Field('minDiesel', _$minDiesel, opt: true);
  static double? _$withLoadConsumption(VehicleModel v) => v.withLoadConsumption;
  static const Field<VehicleModel, double> _f$withLoadConsumption =
      Field('withLoadConsumption', _$withLoadConsumption, opt: true);
  static double? _$withoutLoadConsumption(VehicleModel v) =>
      v.withoutLoadConsumption;
  static const Field<VehicleModel, double> _f$withoutLoadConsumption =
      Field('withoutLoadConsumption', _$withoutLoadConsumption, opt: true);
  static String? _$status(VehicleModel v) => v.status;
  static const Field<VehicleModel, String> _f$status =
      Field('status', _$status, opt: true);

  @override
  final MappableFields<VehicleModel> fields = const {
    #id: _f$id,
    #plateNumber: _f$plateNumber,
    #yearModel: _f$yearModel,
    #maker: _f$maker,
    #category: _f$category,
    #orNumber: _f$orNumber,
    #crNumber: _f$crNumber,
    #fuelLevel: _f$fuelLevel,
    #currentMileage: _f$currentMileage,
    #minDiesel: _f$minDiesel,
    #withLoadConsumption: _f$withLoadConsumption,
    #withoutLoadConsumption: _f$withoutLoadConsumption,
    #status: _f$status,
  };

  static VehicleModel _instantiate(DecodingData data) {
    return VehicleModel(
        id: data.dec(_f$id),
        plateNumber: data.dec(_f$plateNumber),
        yearModel: data.dec(_f$yearModel),
        maker: data.dec(_f$maker),
        category: data.dec(_f$category),
        orNumber: data.dec(_f$orNumber),
        crNumber: data.dec(_f$crNumber),
        fuelLevel: data.dec(_f$fuelLevel),
        currentMileage: data.dec(_f$currentMileage),
        minDiesel: data.dec(_f$minDiesel),
        withLoadConsumption: data.dec(_f$withLoadConsumption),
        withoutLoadConsumption: data.dec(_f$withoutLoadConsumption),
        status: data.dec(_f$status));
  }

  @override
  final Function instantiate = _instantiate;

  static VehicleModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VehicleModel>(map);
  }

  static VehicleModel fromJson(String json) {
    return ensureInitialized().decodeJson<VehicleModel>(json);
  }
}

mixin VehicleModelMappable {
  String toJson() {
    return VehicleModelMapper.ensureInitialized()
        .encodeJson<VehicleModel>(this as VehicleModel);
  }

  Map<String, dynamic> toMap() {
    return VehicleModelMapper.ensureInitialized()
        .encodeMap<VehicleModel>(this as VehicleModel);
  }

  VehicleModelCopyWith<VehicleModel, VehicleModel, VehicleModel> get copyWith =>
      _VehicleModelCopyWithImpl(this as VehicleModel, $identity, $identity);
  @override
  String toString() {
    return VehicleModelMapper.ensureInitialized()
        .stringifyValue(this as VehicleModel);
  }

  @override
  bool operator ==(Object other) {
    return VehicleModelMapper.ensureInitialized()
        .equalsValue(this as VehicleModel, other);
  }

  @override
  int get hashCode {
    return VehicleModelMapper.ensureInitialized()
        .hashValue(this as VehicleModel);
  }
}

extension VehicleModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VehicleModel, $Out> {
  VehicleModelCopyWith<$R, VehicleModel, $Out> get $asVehicleModel =>
      $base.as((v, t, t2) => _VehicleModelCopyWithImpl(v, t, t2));
}

abstract class VehicleModelCopyWith<$R, $In extends VehicleModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? plateNumber,
      int? yearModel,
      String? maker,
      String? category,
      String? orNumber,
      String? crNumber,
      double? fuelLevel,
      int? currentMileage,
      double? minDiesel,
      double? withLoadConsumption,
      double? withoutLoadConsumption,
      String? status});
  VehicleModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VehicleModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VehicleModel, $Out>
    implements VehicleModelCopyWith<$R, VehicleModel, $Out> {
  _VehicleModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VehicleModel> $mapper =
      VehicleModelMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? plateNumber = $none,
          Object? yearModel = $none,
          Object? maker = $none,
          Object? category = $none,
          Object? orNumber = $none,
          Object? crNumber = $none,
          Object? fuelLevel = $none,
          Object? currentMileage = $none,
          Object? minDiesel = $none,
          Object? withLoadConsumption = $none,
          Object? withoutLoadConsumption = $none,
          Object? status = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (plateNumber != $none) #plateNumber: plateNumber,
        if (yearModel != $none) #yearModel: yearModel,
        if (maker != $none) #maker: maker,
        if (category != $none) #category: category,
        if (orNumber != $none) #orNumber: orNumber,
        if (crNumber != $none) #crNumber: crNumber,
        if (fuelLevel != $none) #fuelLevel: fuelLevel,
        if (currentMileage != $none) #currentMileage: currentMileage,
        if (minDiesel != $none) #minDiesel: minDiesel,
        if (withLoadConsumption != $none)
          #withLoadConsumption: withLoadConsumption,
        if (withoutLoadConsumption != $none)
          #withoutLoadConsumption: withoutLoadConsumption,
        if (status != $none) #status: status
      }));
  @override
  VehicleModel $make(CopyWithData data) => VehicleModel(
      id: data.get(#id, or: $value.id),
      plateNumber: data.get(#plateNumber, or: $value.plateNumber),
      yearModel: data.get(#yearModel, or: $value.yearModel),
      maker: data.get(#maker, or: $value.maker),
      category: data.get(#category, or: $value.category),
      orNumber: data.get(#orNumber, or: $value.orNumber),
      crNumber: data.get(#crNumber, or: $value.crNumber),
      fuelLevel: data.get(#fuelLevel, or: $value.fuelLevel),
      currentMileage: data.get(#currentMileage, or: $value.currentMileage),
      minDiesel: data.get(#minDiesel, or: $value.minDiesel),
      withLoadConsumption:
          data.get(#withLoadConsumption, or: $value.withLoadConsumption),
      withoutLoadConsumption:
          data.get(#withoutLoadConsumption, or: $value.withoutLoadConsumption),
      status: data.get(#status, or: $value.status));

  @override
  VehicleModelCopyWith<$R2, VehicleModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _VehicleModelCopyWithImpl($value, $cast, t);
}
