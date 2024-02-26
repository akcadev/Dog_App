import 'package:dog_app/models/breeds_response.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DogEvent {}

class FetchBreedsEvent extends DogEvent {}

class FetchSubBreedsEvent extends DogEvent {
  final String breedName;

  FetchSubBreedsEvent(this.breedName);
}

class ChangeSelectionSubBreedEvent extends DogEvent {
  final int index;
  ChangeSelectionSubBreedEvent(this.index);
}

class FetchSubBreedImageEvent extends DogEvent {
  final String breed;
  FetchSubBreedImageEvent(this.breed);
}

final class SearchBreedEvent extends DogEvent {
  SearchBreedEvent({required this.searchText, required this.breedsList});

  final String searchText;
  final BreedsList breedsList;
  List<Object> get props => [searchText, breedsList];
}

class FailureBreedEvent extends DogEvent {
  FailureBreedEvent({this.errorMessage});
  final String? errorMessage;
}
