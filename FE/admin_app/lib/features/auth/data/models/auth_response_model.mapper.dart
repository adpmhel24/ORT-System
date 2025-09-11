// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_response_model.dart';

class AuthResponseModelMapper extends ClassMapperBase<AuthResponseModel> {
  AuthResponseModelMapper._();

  static AuthResponseModelMapper? _instance;
  static AuthResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthResponseModelMapper._());
      AuthUserModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthResponseModel';

  static AuthUserModel _$data(AuthResponseModel v) => v.data;
  static const Field<AuthResponseModel, AuthUserModel> _f$data =
      Field('data', _$data);
  static String _$accessToken(AuthResponseModel v) => v.accessToken;
  static const Field<AuthResponseModel, String> _f$accessToken =
      Field('accessToken', _$accessToken, key: r'access_token');
  static String _$tokenType(AuthResponseModel v) => v.tokenType;
  static const Field<AuthResponseModel, String> _f$tokenType =
      Field('tokenType', _$tokenType, key: r'token_type');

  @override
  final MappableFields<AuthResponseModel> fields = const {
    #data: _f$data,
    #accessToken: _f$accessToken,
    #tokenType: _f$tokenType,
  };

  static AuthResponseModel _instantiate(DecodingData data) {
    return AuthResponseModel(
        data: data.dec(_f$data),
        accessToken: data.dec(_f$accessToken),
        tokenType: data.dec(_f$tokenType));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthResponseModel>(map);
  }

  static AuthResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<AuthResponseModel>(json);
  }
}

mixin AuthResponseModelMappable {
  String toJson() {
    return AuthResponseModelMapper.ensureInitialized()
        .encodeJson<AuthResponseModel>(this as AuthResponseModel);
  }

  Map<String, dynamic> toMap() {
    return AuthResponseModelMapper.ensureInitialized()
        .encodeMap<AuthResponseModel>(this as AuthResponseModel);
  }

  AuthResponseModelCopyWith<AuthResponseModel, AuthResponseModel,
          AuthResponseModel>
      get copyWith => _AuthResponseModelCopyWithImpl(
          this as AuthResponseModel, $identity, $identity);
  @override
  String toString() {
    return AuthResponseModelMapper.ensureInitialized()
        .stringifyValue(this as AuthResponseModel);
  }

  @override
  bool operator ==(Object other) {
    return AuthResponseModelMapper.ensureInitialized()
        .equalsValue(this as AuthResponseModel, other);
  }

  @override
  int get hashCode {
    return AuthResponseModelMapper.ensureInitialized()
        .hashValue(this as AuthResponseModel);
  }
}

extension AuthResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthResponseModel, $Out> {
  AuthResponseModelCopyWith<$R, AuthResponseModel, $Out>
      get $asAuthResponseModel =>
          $base.as((v, t, t2) => _AuthResponseModelCopyWithImpl(v, t, t2));
}

abstract class AuthResponseModelCopyWith<$R, $In extends AuthResponseModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  AuthUserModelCopyWith<$R, AuthUserModel, AuthUserModel> get data;
  $R call({AuthUserModel? data, String? accessToken, String? tokenType});
  AuthResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthResponseModel, $Out>
    implements AuthResponseModelCopyWith<$R, AuthResponseModel, $Out> {
  _AuthResponseModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthResponseModel> $mapper =
      AuthResponseModelMapper.ensureInitialized();
  @override
  AuthUserModelCopyWith<$R, AuthUserModel, AuthUserModel> get data =>
      $value.data.copyWith.$chain((v) => call(data: v));
  @override
  $R call({AuthUserModel? data, String? accessToken, String? tokenType}) =>
      $apply(FieldCopyWithData({
        if (data != null) #data: data,
        if (accessToken != null) #accessToken: accessToken,
        if (tokenType != null) #tokenType: tokenType
      }));
  @override
  AuthResponseModel $make(CopyWithData data) => AuthResponseModel(
      data: data.get(#data, or: $value.data),
      accessToken: data.get(#accessToken, or: $value.accessToken),
      tokenType: data.get(#tokenType, or: $value.tokenType));

  @override
  AuthResponseModelCopyWith<$R2, AuthResponseModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthResponseModelCopyWithImpl($value, $cast, t);
}
