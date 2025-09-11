import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../../../../core/constants/uri_constants.dart';

part 'vehicle_api_service.g.dart';

@RestApi(baseUrl: UriPath.vehicle)
abstract class VehicleApiService {
  factory VehicleApiService(Dio dio) = _VehicleApiService;

  @POST('')
  Future<HttpResponse> create(@Body() Map<String, dynamic> bodyData);

  @GET('')
  Future<HttpResponse> getAll(@Queries() Map<String, dynamic>? queryParams);
}
