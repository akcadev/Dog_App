import 'package:dog_app/models/breeds_response.dart';
import 'package:dog_app/models/image_response.dart';
import 'package:dog_app/models/sub_breeds_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum Status { initial, loading, success, error }

@immutable
final class DogState extends Equatable {
  const DogState({
    this.breedsList,
    this.subBreeds,
    this.selectionSubBreed,
    this.subBreedImage,
    this.subBreedImageStatus,
  });

  final BreedsList? breedsList;
  final SubBreeds? subBreeds;
  final int? selectionSubBreed;
  final ImageResponse? subBreedImage;
  final Status? subBreedImageStatus;

  @override
  List<Object?> get props => [
        breedsList,
        subBreeds,
        selectionSubBreed,
        subBreedImage,
        subBreedImageStatus
      ];

  DogState copyWith(
      {BreedsList? breedsList,
      SubBreeds? subBreeds,
      int? selectionSubBreed,
      ImageResponse? subBreedImage,
      Status? subBreedImageStatus}) {
    return DogState(
        breedsList: breedsList ?? this.breedsList,
        subBreeds: subBreeds ?? this.subBreeds,
        selectionSubBreed: selectionSubBreed ?? 0,
        subBreedImage: subBreedImage ?? this.subBreedImage,
        subBreedImageStatus: subBreedImageStatus ?? this.subBreedImageStatus);
  }
}

final class DogInitialState extends DogState {}

final class StateBreedsFetching extends DogState {}

final class StateBreedsFetched extends DogState {
  final BreedsList breedsList;

  const StateBreedsFetched(this.breedsList);
}

final class StateSubBreedsFetching extends DogState {}

final class StateSubBreedsFetched extends DogState {
  final SubBreeds subBreeds;

  const StateSubBreedsFetched(this.subBreeds);
}

final class StateSubBreedImageFetching extends DogState {}

final class StateSubBreedImageFetched extends DogState {
  final ImageResponse subBreedImage;

  const StateSubBreedImageFetched(this.subBreedImage);
}
