import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final String largeImageUrl;
  final String previewImageUrl;

  Image({this.largeImageUrl, this.previewImageUrl});

  factory Image.fromMap({Map<String, dynamic> map}) {
    return Image(
      largeImageUrl: map["largeImageURL"],
      previewImageUrl: map["webformatURL"],
    );
  }

  @override
  List<Object> get props => [largeImageUrl, previewImageUrl];
}
