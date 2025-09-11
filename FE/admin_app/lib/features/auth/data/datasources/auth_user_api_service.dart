import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../../../core/constants/uri_constants.dart';

part 'auth_user_api_service.g.dart';

@RestApi(baseUrl: UriPath.authLogin)
abstract class AuthUserApiService {
  factory AuthUserApiService(Dio dio) = _AuthUserApiService;

  // @POST('')
  // Future<HttpResponse> login({@Body() Map<String, dynamic> formData});

  //   @Headers(<String, dynamic>{
  //   'Content-Type': 'multipart/form-data',
  // })

  @POST('')
  Future<HttpResponse> login(@Body() Map<String, dynamic> bodyData);
}
