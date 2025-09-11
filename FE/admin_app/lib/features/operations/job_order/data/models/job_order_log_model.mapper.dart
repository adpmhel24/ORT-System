// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'job_order_log_model.dart';

class JobOrderLogModelMapper extends ClassMapperBase<JobOrderLogModel> {
  JobOrderLogModelMapper._();

  static JobOrderLogModelMapper? _instance;
  static JobOrderLogModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JobOrderLogModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'JobOrderLogModel';

  static int _$id(JobOrderLogModel v) => v.id;
  static const Field<JobOrderLogModel, int> _f$id = Field('id', _$id);
  static String _$notes(JobOrderLogModel v) => v.notes;
  static const Field<JobOrderLogModel, String> _f$notes =
      Field('notes', _$notes);
  static DateTime _$createdAt(JobOrderLogModel v) => v.createdAt;
  static const Field<JobOrderLogModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
  static int _$createdBy(JobOrderLogModel v) => v.createdBy;
  static const Field<JobOrderLogModel, int> _f$createdBy =
      Field('createdBy', _$createdBy, key: r'created_by');

  @override
  final MappableFields<JobOrderLogModel> fields = const {
    #id: _f$id,
    #notes: _f$notes,
    #createdAt: _f$createdAt,
    #createdBy: _f$createdBy,
  };

  static JobOrderLogModel _instantiate(DecodingData data) {
    return JobOrderLogModel(
        id: data.dec(_f$id),
        notes: data.dec(_f$notes),
        createdAt: data.dec(_f$createdAt),
        createdBy: data.dec(_f$createdBy));
  }

  @override
  final Function instantiate = _instantiate;

  static JobOrderLogModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<JobOrderLogModel>(map);
  }

  static JobOrderLogModel fromJson(String json) {
    return ensureInitialized().decodeJson<JobOrderLogModel>(json);
  }
}

mixin JobOrderLogModelMappable {
  String toJson() {
    return JobOrderLogModelMapper.ensureInitialized()
        .encodeJson<JobOrderLogModel>(this as JobOrderLogModel);
  }

  Map<String, dynamic> toMap() {
    return JobOrderLogModelMapper.ensureInitialized()
        .encodeMap<JobOrderLogModel>(this as JobOrderLogModel);
  }

  JobOrderLogModelCopyWith<JobOrderLogModel, JobOrderLogModel, JobOrderLogModel>
      get copyWith => _JobOrderLogModelCopyWithImpl(
          this as JobOrderLogModel, $identity, $identity);
  @override
  String toString() {
    return JobOrderLogModelMapper.ensureInitialized()
        .stringifyValue(this as JobOrderLogModel);
  }

  @override
  bool operator ==(Object other) {
    return JobOrderLogModelMapper.ensureInitialized()
        .equalsValue(this as JobOrderLogModel, other);
  }

  @override
  int get hashCode {
    return JobOrderLogModelMapper.ensureInitialized()
        .hashValue(this as JobOrderLogModel);
  }
}

extension JobOrderLogModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, JobOrderLogModel, $Out> {
  JobOrderLogModelCopyWith<$R, JobOrderLogModel, $Out>
      get $asJobOrderLogModel =>
          $base.as((v, t, t2) => _JobOrderLogModelCopyWithImpl(v, t, t2));
}

abstract class JobOrderLogModelCopyWith<$R, $In extends JobOrderLogModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? notes, DateTime? createdAt, int? createdBy});
  JobOrderLogModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _JobOrderLogModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, JobOrderLogModel, $Out>
    implements JobOrderLogModelCopyWith<$R, JobOrderLogModel, $Out> {
  _JobOrderLogModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<JobOrderLogModel> $mapper =
      JobOrderLogModelMapper.ensureInitialized();
  @override
  $R call({int? id, String? notes, DateTime? createdAt, int? createdBy}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (notes != null) #notes: notes,
        if (createdAt != null) #createdAt: createdAt,
        if (createdBy != null) #createdBy: createdBy
      }));
  @override
  JobOrderLogModel $make(CopyWithData data) => JobOrderLogModel(
      id: data.get(#id, or: $value.id),
      notes: data.get(#notes, or: $value.notes),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      createdBy: data.get(#createdBy, or: $value.createdBy));

  @override
  JobOrderLogModelCopyWith<$R2, JobOrderLogModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _JobOrderLogModelCopyWithImpl($value, $cast, t);
}
