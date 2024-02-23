import 'dart:convert';

class ImageResponse {
  final String? message;
  final String? status;

  ImageResponse({
    this.message,
    this.status,
  });

  factory ImageResponse.fromRawJson(String str) =>
      ImageResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
