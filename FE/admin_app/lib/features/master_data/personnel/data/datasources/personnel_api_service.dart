import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../../../../core/constants/uri_constants.dart';

part 'personnel_api_service.g.dart';

@RestApi(baseUrl: UriPath.personnel)
abstract class PersonnelApiService {
  factory PersonnelApiService(Dio dio) = _PersonnelApiService;

  @POST('')
  Future<HttpResponse> create(@Body() Map<String, dynamic> bodyData);

  @GET('')
  Future<HttpResponse> getAll(@Queries() Map<String, dynamic>? queryParams);
}
