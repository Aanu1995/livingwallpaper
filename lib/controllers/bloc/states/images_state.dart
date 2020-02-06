import 'package:equatable/equatable.dart';
import 'package:livingwallpaper/models/image.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object> get props => [];
}

class ImagesUnInitialized extends ImagesState {}

class ImagesError extends ImagesState {}

class ImagesLoading extends ImagesState {}

class ImagesLoaded extends ImagesState {
  final List<Image> images;
  final bool hasReachedMax;

  ImagesLoaded({this.images, this.hasReachedMax});

  ImagesLoaded copyWith({List<Image> images, bool hasReachedMax}) {
    return ImagesLoaded(
        images: images ?? this.images,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [images, hasReachedMax];

  @override
  String toString() =>
      "Images {length: ${images.length}, hasReachedMax: $hasReachedMax}";
}
