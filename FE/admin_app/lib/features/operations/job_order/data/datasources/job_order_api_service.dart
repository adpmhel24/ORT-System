import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import '../../../../../core/constants/uri_constants.dart';

part 'job_order_api_service.g.dart';

@RestApi(baseUrl: UriPath.jobOrder)
abstract class JobOrderApiService {
  factory JobOrderApiService(Dio dio) = _JobOrderApiService;

  @POST('')
  Future<HttpResponse> create(@Body() Map<String, dynamic> bodyData);

  @GET('')
  Future<HttpResponse> getAll(@Queries() Map<String, dynamic>? queryParams);

  @GET('/{id}')
  Future<HttpResponse> getById(@Path('id') int id);

  @PUT('/{id}')
  Future<HttpResponse> update(
      @Path('id') int id, @Body() Map<String, dynamic> bodyData);

  @DELETE('/{id}')
  Future<HttpResponse> delete(@Path('id') int id);
}
