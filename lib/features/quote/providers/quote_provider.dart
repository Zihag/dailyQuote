import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motivate_me/core/services/native_bridge.dart';
import 'package:motivate_me/features/quote/data/api/api_service.dart';
import '../data/api/api_client.dart';
import '../data/models/quote.dart';

final quoteProvider = FutureProvider<Quote>((ref) async {
  final dio = Dio();
  final apiService = ApiService(dio);

  try {
    print('Send request');
    final quotes = await apiService.getRandomQuote();
    final quote = quotes.first;
    saveQuoteToPrefs(quote.content);
    print('Got response: ${quote.content}');
    return quote;
  } catch (e, stackTrace){
    print('Error call api: $e');
    print('StackTrace: $stackTrace');
    rethrow;
  }
});