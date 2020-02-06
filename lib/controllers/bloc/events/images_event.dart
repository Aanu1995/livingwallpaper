import 'package:equatable/equatable.dart';

abstract class FetchImagesEvent extends Equatable {
  const FetchImagesEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends FetchImagesEvent {
  final String imageCategory;
  const Fetch({this.imageCategory});

  @override
  List<Object> get props => [imageCategory];
}
