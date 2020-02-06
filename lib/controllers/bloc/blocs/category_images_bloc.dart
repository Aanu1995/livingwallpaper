import 'package:livingwallpaper/controllers/bloc/events/images_event.dart';
import 'package:livingwallpaper/controllers/bloc/states/images_state.dart';
import 'package:bloc/bloc.dart';
import 'package:livingwallpaper/models/image.dart';
import 'package:livingwallpaper/services/api.dart';
import 'package:rxdart/rxdart.dart';

class CategoryImagesBloc extends Bloc<FetchImagesEvent, ImagesState> {
  @override
  ImagesState get initialState => ImagesUnInitialized();

  @override
  Stream<ImagesState> transformEvents(Stream<FetchImagesEvent> events,
      Stream<ImagesState> Function(FetchImagesEvent) next) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)), next);
  }

  @override
  Stream<ImagesState> mapEventToState(FetchImagesEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ImagesUnInitialized) {
          yield ImagesLoading();
          final List<Image> images =
              await ApiService.getAllImages(category: event.imageCategory);
          yield ImagesLoaded(
              images: images, hasReachedMax: images.length < 20 ? true : false);
        }
        if (currentState is ImagesLoaded) {
          int pageNumber = (currentState.images.length / 20).ceil() + 1;
          final List<Image> images = await ApiService.getAllImages(
              pageNumber: pageNumber, category: event.imageCategory);
          yield images.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ImagesLoaded(
                  images: currentState.images + images, hasReachedMax: false);
        }
        if (currentState is ImagesError) {
          yield ImagesLoading();
          final List<Image> images =
              await ApiService.getAllImages(category: event.imageCategory);
          yield ImagesLoaded(
              images: images, hasReachedMax: images.length < 20 ? true : false);
        }
      } catch (_) {
        yield ImagesError();
      }
    }
  }

  bool _hasReachedMax(ImagesState state) =>
      state is ImagesLoaded && state.hasReachedMax;
}
