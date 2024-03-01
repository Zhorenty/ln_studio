import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';

class Review {
  const Review({
    required this.id,
    required this.createdAt,
    required this.text,
  });
  final int id;
  final String createdAt;
  final String text;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']).defaultFormat(),
      text: json['text'],
    );
  }
}
