import 'package:dog_app/models/image_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum Status { initial, loading, success, error }

@immutable
abstract class DogState extends Equatable {}

final class DogInitialState extends DogState {
  @override
  List<Object?> get props => [];
}

final class StateBreedsFetching extends DogState {
  @override
  List<Object?> get props => [];
}

final class StateBreedsCaching extends DogState {
  @override
  List<Object?> get props => [];
}

final class SuccessState<T, R> extends DogState {
  SuccessState({required this.data});

  final R? data;
  @override
  List<dynamic> get props => [data];
}

final class FailureState<Failure> extends DogState {
  FailureState({required this.failure});

  final Failure failure;
  @override
  List<dynamic> get props => [failure];
}

final class StateSubBreedImageFetching extends DogState {
  @override
  List<Object?> get props => [];
}

final class StateSubBreedImageFetched extends DogState {
  StateSubBreedImageFetched(this.subBreedImage);
  final ImageResponse subBreedImage;

  @override
  List<Object?> get props => [subBreedImage];
}
