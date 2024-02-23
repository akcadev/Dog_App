import 'package:flutter/cupertino.dart';

@immutable
abstract class DogEvent {}

class FetchBreedsEvent extends DogEvent {}

class FetchSubBreedsEvent extends DogEvent {
  final String subBreedName;

  FetchSubBreedsEvent(this.subBreedName);
}

class ChangeSelectionSubBreedEvent extends DogEvent {
  final int index;
  ChangeSelectionSubBreedEvent(this.index);
}

class FetchSubBreedImageEvent extends DogEvent {
  final String breed;
  final String subBreed;
  FetchSubBreedImageEvent(this.breed, this.subBreed);
}
