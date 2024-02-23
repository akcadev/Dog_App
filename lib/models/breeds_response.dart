import 'dart:convert';

class BreedsList {
  final List<Breed>? breeds;
  final String? status;

  BreedsList(
    this.breeds,
    this.status,
  );

  factory BreedsList.fromRawJson(String str) =>
      BreedsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BreedsList.fromJson(Map<String, dynamic> json) {
    final List<String> message =
        json['message'] != null ? List<String>.from(json['message']) : [];
    final breeds = message
        .map((breedName) =>
            Breed(breedName, ''))
        .toList();
    return BreedsList(breeds, json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'breeds': breeds!.map((breed) => breed.toJson()).toList(),
      'status': status,
    };
  }
}

class Breed {
  String breedName;
  String imageUrl;

  Breed(this.breedName, this.imageUrl);

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(json['breedName'], json['imageUrl']);
  }
  Map<String, dynamic> toJson() {
    return {
      'breedName': breedName,
      'imageUrl': imageUrl,
    };
  }
}
