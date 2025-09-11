// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_user_model.dart';

class AuthUserModelMapper extends ClassMapperBase<AuthUserModel> {
  AuthUserModelMapper._();

  static AuthUserModelMapper? _instance;
  static AuthUserModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUserModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AuthUserModel';

  static String? _$id(AuthUserModel v) => v.id;
  static const Field<AuthUserModel, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$fullname(AuthUserModel v) => v.fullname;
  static const Field<AuthUserModel, String> _f$fullname =
      Field('fullname', _$fullname, opt: true);
  static bool? _$isActive(AuthUserModel v) => v.isActive;
  static const Field<AuthUserModel, bool> _f$isActive =
      Field('isActive', _$isActive, key: r'is_active', opt: true);
  static bool? _$isAdmin(AuthUserModel v) => v.isAdmin;
  static const Field<AuthUserModel, bool> _f$isAdmin =
      Field('isAdmin', _$isAdmin, key: r'is_admin', opt: true);
  static bool? _$isSuperUser(AuthUserModel v) => v.isSuperUser;
  static const Field<AuthUserModel, bool> _f$isSuperUser =
      Field('isSuperUser', _$isSuperUser, key: r'is_superuser', opt: true);
  static String? _$userTypeCode(AuthUserModel v) => v.userTypeCode;
  static const Field<AuthUserModel, String> _f$userTypeCode =
      Field('userTypeCode', _$userTypeCode, key: r'user_type_code', opt: true);
  static String? _$username(AuthUserModel v) => v.username;
  static const Field<AuthUserModel, String> _f$username =
      Field('username', _$username, opt: true);

  @override
  final MappableFields<AuthUserModel> fields = const {
    #id: _f$id,
    #fullname: _f$fullname,
    #isActive: _f$isActive,
    #isAdmin: _f$isAdmin,
    #isSuperUser: _f$isSuperUser,
    #userTypeCode: _f$userTypeCode,
    #username: _f$username,
  };

  static AuthUserModel _instantiate(DecodingData data) {
    return AuthUserModel(
        id: data.dec(_f$id),
        fullname: data.dec(_f$fullname),
        isActive: data.dec(_f$isActive),
        isAdmin: data.dec(_f$isAdmin),
        isSuperUser: data.dec(_f$isSuperUser),
        userTypeCode: data.dec(_f$userTypeCode),
        username: data.dec(_f$username));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthUserModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthUserModel>(map);
  }

  static AuthUserModel fromJson(String json) {
    return ensureInitialized().decodeJson<AuthUserModel>(json);
  }
}

mixin AuthUserModelMappable {
  String toJson() {
    return AuthUserModelMapper.ensureInitialized()
        .encodeJson<AuthUserModel>(this as AuthUserModel);
  }

  Map<String, dynamic> toMap() {
    return AuthUserModelMapper.ensureInitialized()
        .encodeMap<AuthUserModel>(this as AuthUserModel);
  }

  AuthUserModelCopyWith<AuthUserModel, AuthUserModel, AuthUserModel>
      get copyWith => _AuthUserModelCopyWithImpl(
          this as AuthUserModel, $identity, $identity);
  @override
  String toString() {
    return AuthUserModelMapper.ensureInitialized()
        .stringifyValue(this as AuthUserModel);
  }

  @override
  bool operator ==(Object other) {
    return AuthUserModelMapper.ensureInitialized()
        .equalsValue(this as AuthUserModel, other);
  }

  @override
  int get hashCode {
    return AuthUserModelMapper.ensureInitialized()
        .hashValue(this as AuthUserModel);
  }
}

extension AuthUserModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthUserModel, $Out> {
  AuthUserModelCopyWith<$R, AuthUserModel, $Out> get $asAuthUserModel =>
      $base.as((v, t, t2) => _AuthUserModelCopyWithImpl(v, t, t2));
}

abstract class AuthUserModelCopyWith<$R, $In extends AuthUserModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? fullname,
      bool? isActive,
      bool? isAdmin,
      bool? isSuperUser,
      String? userTypeCode,
      String? username});
  AuthUserModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthUserModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthUserModel, $Out>
    implements AuthUserModelCopyWith<$R, AuthUserModel, $Out> {
  _AuthUserModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthUserModel> $mapper =
      AuthUserModelMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? fullname = $none,
          Object? isActive = $none,
          Object? isAdmin = $none,
          Object? isSuperUser = $none,
          Object? userTypeCode = $none,
          Object? username = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (fullname != $none) #fullname: fullname,
        if (isActive != $none) #isActive: isActive,
        if (isAdmin != $none) #isAdmin: isAdmin,
        if (isSuperUser != $none) #isSuperUser: isSuperUser,
        if (userTypeCode != $none) #userTypeCode: userTypeCode,
        if (username != $none) #username: username
      }));
  @override
  AuthUserModel $make(CopyWithData data) => AuthUserModel(
      id: data.get(#id, or: $value.id),
      fullname: data.get(#fullname, or: $value.fullname),
      isActive: data.get(#isActive, or: $value.isActive),
      isAdmin: data.get(#isAdmin, or: $value.isAdmin),
      isSuperUser: data.get(#isSuperUser, or: $value.isSuperUser),
      userTypeCode: data.get(#userTypeCode, or: $value.userTypeCode),
      username: data.get(#username, or: $value.username));

  @override
  AuthUserModelCopyWith<$R2, AuthUserModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthUserModelCopyWithImpl($value, $cast, t);
}
