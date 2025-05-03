import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote {
  @JsonKey(name: 'q')
  final String content;

  @JsonKey(name: 'a')
  final String author;

  Quote({
    required this.content,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
