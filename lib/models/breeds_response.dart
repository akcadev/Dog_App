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
    final Map<String, List<String>> message = Map.from(json["message"]!).map((k,
            v) =>
        MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x))));
    final List<Breed> breedList = [];
    for (var element in message.entries) {
      breedList.add(Breed(
          element.key,
          message.entries
                  .where((e) => e.key == element.key.toString())
                  .firstOrNull
                  ?.value ??
              [],
          "imageUrl"));
    }

    return BreedsList(breedList, json['status']);
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
  List<String> subBreeds;
  String imageUrl;

  Breed(this.breedName, this.subBreeds, this.imageUrl);

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(json['breedName'], json['subBreeds'], json['imageUrl']);
  }
  Map<String, dynamic> toJson() {
    return {
      'breedName': breedName,
      'subBreeds': subBreeds,
      'imageUrl': imageUrl,
    };
  }
}
