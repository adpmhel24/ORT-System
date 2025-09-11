// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'job_order_model.dart';

class JobOrderModelMapper extends ClassMapperBase<JobOrderModel> {
  JobOrderModelMapper._();

  static JobOrderModelMapper? _instance;
  static JobOrderModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JobOrderModelMapper._());
      JobOrderLogModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'JobOrderModel';

  static int _$id(JobOrderModel v) => v.id;
  static const Field<JobOrderModel, int> _f$id = Field('id', _$id);
  static String _$reference(JobOrderModel v) => v.reference;
  static const Field<JobOrderModel, String> _f$reference =
      Field('reference', _$reference);
  static String _$bpName(JobOrderModel v) => v.bpName;
  static const Field<JobOrderModel, String> _f$bpName =
      Field('bpName', _$bpName);
  static DateTime _$jobDate(JobOrderModel v) => v.jobDate;
  static const Field<JobOrderModel, DateTime> _f$jobDate =
      Field('jobDate', _$jobDate);
  static String? _$remarks(JobOrderModel v) => v.remarks;
  static const Field<JobOrderModel, String> _f$remarks =
      Field('remarks', _$remarks, opt: true);
  static String? _$contactNumber(JobOrderModel v) => v.contactNumber;
  static const Field<JobOrderModel, String> _f$contactNumber =
      Field('contactNumber', _$contactNumber, opt: true);
  static String _$jobDescription(JobOrderModel v) => v.jobDescription;
  static const Field<JobOrderModel, String> _f$jobDescription =
      Field('jobDescription', _$jobDescription);
  static String _$status(JobOrderModel v) => v.status;
  static const Field<JobOrderModel, String> _f$status =
      Field('status', _$status);
  static String _$pickupAddress(JobOrderModel v) => v.pickupAddress;
  static const Field<JobOrderModel, String> _f$pickupAddress =
      Field('pickupAddress', _$pickupAddress);
  static String _$deliveryAddress(JobOrderModel v) => v.deliveryAddress;
  static const Field<JobOrderModel, String> _f$deliveryAddress =
      Field('deliveryAddress', _$deliveryAddress);
  static double _$pickupLat(JobOrderModel v) => v.pickupLat;
  static const Field<JobOrderModel, double> _f$pickupLat =
      Field('pickupLat', _$pickupLat);
  static double _$pickupLong(JobOrderModel v) => v.pickupLong;
  static const Field<JobOrderModel, double> _f$pickupLong =
      Field('pickupLong', _$pickupLong);
  static double _$deliveryLat(JobOrderModel v) => v.deliveryLat;
  static const Field<JobOrderModel, double> _f$deliveryLat =
      Field('deliveryLat', _$deliveryLat);
  static double _$deliveryLong(JobOrderModel v) => v.deliveryLong;
  static const Field<JobOrderModel, double> _f$deliveryLong =
      Field('deliveryLong', _$deliveryLong);
  static List<JobOrderLogModel> _$logNotes(JobOrderModel v) => v.logNotes;
  static const Field<JobOrderModel, List<JobOrderLogModel>> _f$logNotes =
      Field('logNotes', _$logNotes, opt: true, def: const []);

  @override
  final MappableFields<JobOrderModel> fields = const {
    #id: _f$id,
    #reference: _f$reference,
    #bpName: _f$bpName,
    #jobDate: _f$jobDate,
    #remarks: _f$remarks,
    #contactNumber: _f$contactNumber,
    #jobDescription: _f$jobDescription,
    #status: _f$status,
    #pickupAddress: _f$pickupAddress,
    #deliveryAddress: _f$deliveryAddress,
    #pickupLat: _f$pickupLat,
    #pickupLong: _f$pickupLong,
    #deliveryLat: _f$deliveryLat,
    #deliveryLong: _f$deliveryLong,
    #logNotes: _f$logNotes,
  };

  static JobOrderModel _instantiate(DecodingData data) {
    return JobOrderModel(
        id: data.dec(_f$id),
        reference: data.dec(_f$reference),
        bpName: data.dec(_f$bpName),
        jobDate: data.dec(_f$jobDate),
        remarks: data.dec(_f$remarks),
        contactNumber: data.dec(_f$contactNumber),
        jobDescription: data.dec(_f$jobDescription),
        status: data.dec(_f$status),
        pickupAddress: data.dec(_f$pickupAddress),
        deliveryAddress: data.dec(_f$deliveryAddress),
        pickupLat: data.dec(_f$pickupLat),
        pickupLong: data.dec(_f$pickupLong),
        deliveryLat: data.dec(_f$deliveryLat),
        deliveryLong: data.dec(_f$deliveryLong),
        logNotes: data.dec(_f$logNotes));
  }

  @override
  final Function instantiate = _instantiate;

  static JobOrderModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<JobOrderModel>(map);
  }

  static JobOrderModel fromJson(String json) {
    return ensureInitialized().decodeJson<JobOrderModel>(json);
  }
}

mixin JobOrderModelMappable {
  String toJson() {
    return JobOrderModelMapper.ensureInitialized()
        .encodeJson<JobOrderModel>(this as JobOrderModel);
  }

  Map<String, dynamic> toMap() {
    return JobOrderModelMapper.ensureInitialized()
        .encodeMap<JobOrderModel>(this as JobOrderModel);
  }

  JobOrderModelCopyWith<JobOrderModel, JobOrderModel, JobOrderModel>
      get copyWith => _JobOrderModelCopyWithImpl(
          this as JobOrderModel, $identity, $identity);
  @override
  String toString() {
    return JobOrderModelMapper.ensureInitialized()
        .stringifyValue(this as JobOrderModel);
  }

  @override
  bool operator ==(Object other) {
    return JobOrderModelMapper.ensureInitialized()
        .equalsValue(this as JobOrderModel, other);
  }

  @override
  int get hashCode {
    return JobOrderModelMapper.ensureInitialized()
        .hashValue(this as JobOrderModel);
  }
}

extension JobOrderModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, JobOrderModel, $Out> {
  JobOrderModelCopyWith<$R, JobOrderModel, $Out> get $asJobOrderModel =>
      $base.as((v, t, t2) => _JobOrderModelCopyWithImpl(v, t, t2));
}

abstract class JobOrderModelCopyWith<$R, $In extends JobOrderModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, JobOrderLogModel,
          JobOrderLogModelCopyWith<$R, JobOrderLogModel, JobOrderLogModel>>
      get logNotes;
  $R call(
      {int? id,
      String? reference,
      String? bpName,
      DateTime? jobDate,
      String? remarks,
      String? contactNumber,
      String? jobDescription,
      String? status,
      String? pickupAddress,
      String? deliveryAddress,
      double? pickupLat,
      double? pickupLong,
      double? deliveryLat,
      double? deliveryLong,
      List<JobOrderLogModel>? logNotes});
  JobOrderModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _JobOrderModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, JobOrderModel, $Out>
    implements JobOrderModelCopyWith<$R, JobOrderModel, $Out> {
  _JobOrderModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<JobOrderModel> $mapper =
      JobOrderModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, JobOrderLogModel,
          JobOrderLogModelCopyWith<$R, JobOrderLogModel, JobOrderLogModel>>
      get logNotes => ListCopyWith($value.logNotes,
          (v, t) => v.copyWith.$chain(t), (v) => call(logNotes: v));
  @override
  $R call(
          {int? id,
          String? reference,
          String? bpName,
          DateTime? jobDate,
          Object? remarks = $none,
          Object? contactNumber = $none,
          String? jobDescription,
          String? status,
          String? pickupAddress,
          String? deliveryAddress,
          double? pickupLat,
          double? pickupLong,
          double? deliveryLat,
          double? deliveryLong,
          List<JobOrderLogModel>? logNotes}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (reference != null) #reference: reference,
        if (bpName != null) #bpName: bpName,
        if (jobDate != null) #jobDate: jobDate,
        if (remarks != $none) #remarks: remarks,
        if (contactNumber != $none) #contactNumber: contactNumber,
        if (jobDescription != null) #jobDescription: jobDescription,
        if (status != null) #status: status,
        if (pickupAddress != null) #pickupAddress: pickupAddress,
        if (deliveryAddress != null) #deliveryAddress: deliveryAddress,
        if (pickupLat != null) #pickupLat: pickupLat,
        if (pickupLong != null) #pickupLong: pickupLong,
        if (deliveryLat != null) #deliveryLat: deliveryLat,
        if (deliveryLong != null) #deliveryLong: deliveryLong,
        if (logNotes != null) #logNotes: logNotes
      }));
  @override
  JobOrderModel $make(CopyWithData data) => JobOrderModel(
      id: data.get(#id, or: $value.id),
      reference: data.get(#reference, or: $value.reference),
      bpName: data.get(#bpName, or: $value.bpName),
      jobDate: data.get(#jobDate, or: $value.jobDate),
      remarks: data.get(#remarks, or: $value.remarks),
      contactNumber: data.get(#contactNumber, or: $value.contactNumber),
      jobDescription: data.get(#jobDescription, or: $value.jobDescription),
      status: data.get(#status, or: $value.status),
      pickupAddress: data.get(#pickupAddress, or: $value.pickupAddress),
      deliveryAddress: data.get(#deliveryAddress, or: $value.deliveryAddress),
      pickupLat: data.get(#pickupLat, or: $value.pickupLat),
      pickupLong: data.get(#pickupLong, or: $value.pickupLong),
      deliveryLat: data.get(#deliveryLat, or: $value.deliveryLat),
      deliveryLong: data.get(#deliveryLong, or: $value.deliveryLong),
      logNotes: data.get(#logNotes, or: $value.logNotes));

  @override
  JobOrderModelCopyWith<$R2, JobOrderModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _JobOrderModelCopyWithImpl($value, $cast, t);
}
