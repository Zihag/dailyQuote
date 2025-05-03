import 'package:flutter/services.dart';

const _platform = MethodChannel('quote_channel');

Future<void> saveQuoteToPrefs(String quote) async {
  try {
    await _platform.invokeMethod('saveQuote', {"quote": quote});
  } catch (e){
    print('Error saved quote: $e');
  }
}