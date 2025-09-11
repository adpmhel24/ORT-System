import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../../../../core/constants/uri_constants.dart';

part 'empl_position_api_service.g.dart';

@RestApi(baseUrl: UriPath.emplPosition)
abstract class EmplPositionApiService {
  factory EmplPositionApiService(Dio dio) = _EmplPositionApiService;

  @POST('')
  Future<HttpResponse> create(@Body() Map<String, dynamic> bodyData);

  @GET('')
  Future<HttpResponse> getAll(@Queries() Map<String, dynamic>? queryParams);
}
