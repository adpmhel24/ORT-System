// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bp_model.dart';

class BusinessPartnerModelMapper extends ClassMapperBase<BusinessPartnerModel> {
  BusinessPartnerModelMapper._();

  static BusinessPartnerModelMapper? _instance;
  static BusinessPartnerModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BusinessPartnerModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BusinessPartnerModel';

  static int _$id(BusinessPartnerModel v) => v.id;
  static const Field<BusinessPartnerModel, int> _f$id = Field('id', _$id);
  static String _$bpName(BusinessPartnerModel v) => v.bpName;
  static const Field<BusinessPartnerModel, String> _f$bpName =
      Field('bpName', _$bpName);
  static String _$contactPerson(BusinessPartnerModel v) => v.contactPerson;
  static const Field<BusinessPartnerModel, String> _f$contactPerson =
      Field('contactPerson', _$contactPerson);
  static String _$bpType(BusinessPartnerModel v) => v.bpType;
  static const Field<BusinessPartnerModel, String> _f$bpType =
      Field('bpType', _$bpType);
  static String? _$address(BusinessPartnerModel v) => v.address;
  static const Field<BusinessPartnerModel, String> _f$address =
      Field('address', _$address, opt: true);
  static String? _$contactNumber(BusinessPartnerModel v) => v.contactNumber;
  static const Field<BusinessPartnerModel, String> _f$contactNumber =
      Field('contactNumber', _$contactNumber, opt: true);
  static double? _$lat(BusinessPartnerModel v) => v.lat;
  static const Field<BusinessPartnerModel, double> _f$lat =
      Field('lat', _$lat, opt: true);
  static double? _$long(BusinessPartnerModel v) => v.long;
  static const Field<BusinessPartnerModel, double> _f$long =
      Field('long', _$long, opt: true);
  static bool _$isActive(BusinessPartnerModel v) => v.isActive;
  static const Field<BusinessPartnerModel, bool> _f$isActive =
      Field('isActive', _$isActive, opt: true, def: true);

  @override
  final MappableFields<BusinessPartnerModel> fields = const {
    #id: _f$id,
    #bpName: _f$bpName,
    #contactPerson: _f$contactPerson,
    #bpType: _f$bpType,
    #address: _f$address,
    #contactNumber: _f$contactNumber,
    #lat: _f$lat,
    #long: _f$long,
    #isActive: _f$isActive,
  };

  static BusinessPartnerModel _instantiate(DecodingData data) {
    return BusinessPartnerModel(
        id: data.dec(_f$id),
        bpName: data.dec(_f$bpName),
        contactPerson: data.dec(_f$contactPerson),
        bpType: data.dec(_f$bpType),
        address: data.dec(_f$address),
        contactNumber: data.dec(_f$contactNumber),
        lat: data.dec(_f$lat),
        long: data.dec(_f$long),
        isActive: data.dec(_f$isActive));
  }

  @override
  final Function instantiate = _instantiate;

  static BusinessPartnerModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BusinessPartnerModel>(map);
  }

  static BusinessPartnerModel fromJson(String json) {
    return ensureInitialized().decodeJson<BusinessPartnerModel>(json);
  }
}

mixin BusinessPartnerModelMappable {
  String toJson() {
    return BusinessPartnerModelMapper.ensureInitialized()
        .encodeJson<BusinessPartnerModel>(this as BusinessPartnerModel);
  }

  Map<String, dynamic> toMap() {
    return BusinessPartnerModelMapper.ensureInitialized()
        .encodeMap<BusinessPartnerModel>(this as BusinessPartnerModel);
  }

  BusinessPartnerModelCopyWith<BusinessPartnerModel, BusinessPartnerModel,
          BusinessPartnerModel>
      get copyWith => _BusinessPartnerModelCopyWithImpl(
          this as BusinessPartnerModel, $identity, $identity);
  @override
  String toString() {
    return BusinessPartnerModelMapper.ensureInitialized()
        .stringifyValue(this as BusinessPartnerModel);
  }

  @override
  bool operator ==(Object other) {
    return BusinessPartnerModelMapper.ensureInitialized()
        .equalsValue(this as BusinessPartnerModel, other);
  }

  @override
  int get hashCode {
    return BusinessPartnerModelMapper.ensureInitialized()
        .hashValue(this as BusinessPartnerModel);
  }
}

extension BusinessPartnerModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BusinessPartnerModel, $Out> {
  BusinessPartnerModelCopyWith<$R, BusinessPartnerModel, $Out>
      get $asBusinessPartnerModel =>
          $base.as((v, t, t2) => _BusinessPartnerModelCopyWithImpl(v, t, t2));
}

abstract class BusinessPartnerModelCopyWith<
    $R,
    $In extends BusinessPartnerModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? bpName,
      String? contactPerson,
      String? bpType,
      String? address,
      String? contactNumber,
      double? lat,
      double? long,
      bool? isActive});
  BusinessPartnerModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BusinessPartnerModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BusinessPartnerModel, $Out>
    implements BusinessPartnerModelCopyWith<$R, BusinessPartnerModel, $Out> {
  _BusinessPartnerModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BusinessPartnerModel> $mapper =
      BusinessPartnerModelMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          String? bpName,
          String? contactPerson,
          String? bpType,
          Object? address = $none,
          Object? contactNumber = $none,
          Object? lat = $none,
          Object? long = $none,
          bool? isActive}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (bpName != null) #bpName: bpName,
        if (contactPerson != null) #contactPerson: contactPerson,
        if (bpType != null) #bpType: bpType,
        if (address != $none) #address: address,
        if (contactNumber != $none) #contactNumber: contactNumber,
        if (lat != $none) #lat: lat,
        if (long != $none) #long: long,
        if (isActive != null) #isActive: isActive
      }));
  @override
  BusinessPartnerModel $make(CopyWithData data) => BusinessPartnerModel(
      id: data.get(#id, or: $value.id),
      bpName: data.get(#bpName, or: $value.bpName),
      contactPerson: data.get(#contactPerson, or: $value.contactPerson),
      bpType: data.get(#bpType, or: $value.bpType),
      address: data.get(#address, or: $value.address),
      contactNumber: data.get(#contactNumber, or: $value.contactNumber),
      lat: data.get(#lat, or: $value.lat),
      long: data.get(#long, or: $value.long),
      isActive: data.get(#isActive, or: $value.isActive));

  @override
  BusinessPartnerModelCopyWith<$R2, BusinessPartnerModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _BusinessPartnerModelCopyWithImpl($value, $cast, t);
}
