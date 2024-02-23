import 'dart:convert';

class SubBreeds {
    final List<String>? subBreeds;
    final String? status;

    SubBreeds({
        this.subBreeds,
        this.status,
    });

    SubBreeds copyWith({
        List<String>? message,
        String? status,
    }) => 
        SubBreeds(
            subBreeds: message ?? this.subBreeds,
            status: status ?? this.status,
        );

    factory SubBreeds.fromRawJson(String str) => SubBreeds.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubBreeds.fromJson(Map<String, dynamic> json) => SubBreeds(
        subBreeds: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": subBreeds == null ? [] : List<dynamic>.from(subBreeds!.map((x) => x)),
        "status": status,
    };
}
