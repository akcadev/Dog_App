import 'package:dog_app/api/api_provider.dart';
import 'package:dog_app/models/breeds_response.dart';
import 'package:dog_app/models/image_response.dart';
import 'package:dog_app/models/sub_breeds_response.dart';

class ApiRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<BreedsList?> fetchBreeds() async {
    final res = await apiProvider.fetchData('breeds/list/all');
    return BreedsList.fromJson(res.data);
  }

  Future<ImageResponse?> fetchBreedImage(String breedName,
      {bool? subBreed}) async {
    final res = await apiProvider.fetchData('breed/$breedName/images/random');
    return ImageResponse.fromJson(res.data);
  }

  Future<SubBreeds?> fetchSubBreeds(String subBreedName) async {
    final res = await apiProvider.fetchData('breed/$subBreedName/list');
    return SubBreeds.fromJson(res.data);
  }

  Future<ImageResponse?> fetchSubBreedImage(
      String breedName) async {
    final res = await apiProvider
        .fetchData('breed/$breedName/images/random');
    return ImageResponse.fromJson(res.data);
  }
}
