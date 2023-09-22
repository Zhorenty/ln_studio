///
class QRCode {
  QRCode({required this.url});

  ///
  final String url;

  factory QRCode.fromJson(Map<String, Object?> json) => QRCode(
        url: json['url']! as String,
      );
}
