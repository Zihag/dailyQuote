import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/quote.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: 'https://zenquotes.io/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("api/random")
  Future<List<Quote>> getRandomQuote();
}