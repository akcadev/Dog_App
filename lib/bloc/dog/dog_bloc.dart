import 'package:dog_app/api/api_repository.dart';
import 'package:dog_app/bloc/dog/dog_event.dart';
import 'package:dog_app/bloc/dog/dog_state.dart';
import 'package:dog_app/utils/image_cache_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  final ApiRepository _apiRepository;
  final ImageCacheManager imageCacheManager = ImageCacheManager();

  DogBloc(this._apiRepository) : super(DogInitialState()) {
    on<FetchBreedsEvent>(fetchBreedsList);
    on<FetchSubBreedsEvent>(fetchSubBreeds);
    on<ChangeSelectionSubBreedEvent>(changeSelectionSubBreed);
    on<FetchSubBreedImageEvent>(fetchSubBreedImage);
  }

  fetchBreedsList(FetchBreedsEvent event, emit) async {
    final List<Future<void>> futures = [];

    final response = await _apiRepository.fetchBreeds();
    if (response != null) {
      for (var element in response.breeds!) {
        final imgResponse =
            await _apiRepository.fetchBreedImage(element.breedName);

        element.imageUrl = imgResponse!.message!;
        futures.add(imageCacheManager.precacheImage('${imgResponse.message}'));
      }
      await Future.wait(futures);

      emit(StateBreedsFetched(response));
    }
  }

  fetchSubBreeds(FetchSubBreedsEvent event, emit) async {
    final response = await _apiRepository.fetchSubBreeds(event.subBreedName);
    if (response != null) {
      emit(state.copyWith(subBreeds: response));
    }
  }

  fetchSubBreedImage(FetchSubBreedImageEvent event, emit) async {
    emit(state.copyWith(subBreedImageStatus: Status.loading));
    final response =
        await _apiRepository.fetchSubBreedImage(event.breed, event.subBreed);
    if (response != null) {
      emit(state.copyWith(
          subBreedImage: response, subBreedImageStatus: Status.success));
    }
  }

  changeSelectionSubBreed(ChangeSelectionSubBreedEvent event, emit) async {
    emit(state.copyWith(selectionSubBreed: event.index));
  }

  changeImageStatus(Status status) async {
    emit(state.copyWith(subBreedImageStatus: status));
  }
}
