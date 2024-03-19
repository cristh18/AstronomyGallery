import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/apod_response_dto.dart';

part 'apod_api.g.dart';

@RestApi(baseUrl: 'https://api.nasa.gov/planetary/')
abstract class APODApi {
  factory APODApi(Dio dio, {String baseUrl}) = _APODApi;

  @GET('/apod')
  Future<List<APODResponseDTO>> getApods(@Query('count') int count,
      @Query('thumbs') bool thumbs, @Query('api_key') String apiKey);
}
