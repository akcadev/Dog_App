import 'package:dog_app/api/api_repository.dart';
import 'package:dog_app/business_logic/index.dart';
import 'package:dog_app/models/index.dart';
import 'package:dog_app/utils/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  final ApiRepository _apiRepository;
  final ImageCacheManager imageCacheManager = ImageCacheManager();

  DogBloc(this._apiRepository) : super(DogInitialState()) {
    on<FetchBreedsEvent>(_fetchBreedsList);
    on<FetchSubBreedImageEvent>(_fetchSubBreedImage);
    on<SearchBreedEvent>(_searchBreed);
  }

  _fetchBreedsList(FetchBreedsEvent event, emit) async {
    emit(StateBreedsFetching());
    final response = await _apiRepository.fetchBreeds();
    if (response != null) {
      emit(StateBreedsCaching());
      for (var element in response.breeds!) {
        final imgResponse =
            await _apiRepository.fetchBreedImage(element.breedName);

        element.imageUrl = imgResponse!.message!;
        imageCacheManager.precacheImage('${imgResponse.message}');
      }
      emit(SuccessState<FetchBreedsEvent, BreedsList>(data: response));
    }
  }

  _fetchSubBreedImage(FetchSubBreedImageEvent event, emit) async {
    emit(StateSubBreedImageFetching());
    final response =
        await _apiRepository.fetchSubBreedImage(event.breed);
    if (response != null) {
      emit(StateSubBreedImageFetched(response));
    }
  }

  Future<void> _searchBreed(SearchBreedEvent event, emit) async {
    BreedsList? breedsList = event.breedsList;
    final searchResult = breedsList.breeds
        ?.where((element) =>
            element.breedName.contains(event.searchText.toLowerCase()))
        .toList();
    if (searchResult!.isNotEmpty) {
      emit(SuccessState<SearchBreedEvent, BreedsList>(
          data: BreedsList(searchResult, "null")));
    } else {
      emit(FailureState(failure: ""));
    }
  }
}
