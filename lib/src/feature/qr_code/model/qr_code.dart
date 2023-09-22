///
class QRCode {
  QRCode({required this.url});

  ///
  final String url;

  ///
  // final bool isWorking

  factory QRCode.fromJson(Map<String, Object?> json) => QRCode(
        url: json['url']! as String,
      );
}
