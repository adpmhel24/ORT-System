import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../../../../core/constants/uri_constants.dart';

part 'bp_api_service.g.dart';

@RestApi(baseUrl: UriPath.bp)
abstract class BPApiService {
  factory BPApiService(Dio dio) = _BPApiService;

  @POST('')
  Future<HttpResponse> create(@Body() Map<String, dynamic> bodyData);

  @GET('')
  Future<HttpResponse> getAll(@Queries() Map<String, dynamic>? queryParams);
}
