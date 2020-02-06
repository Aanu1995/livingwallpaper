import 'package:flutter/material.dart';

import 'package:livingwallpaper/controllers/bloc/bloc.dart';
import 'package:livingwallpaper/router/router.dart';
import 'package:livingwallpaper/views/components/components.dart';
import 'package:livingwallpaper/views/image_view_page.dart';

class LoadedImages extends StatelessWidget {
  final ImagesLoaded state;
  final ScrollController scrollController;
  final BoxConstraints constraints;
  const LoadedImages(this.state, this.scrollController, this.constraints);
  @override
  Widget build(BuildContext context) {
    if (state.images.isNotEmpty) {
      return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: <Widget>[
            // Displays the images in grid
            GridViewCardImage(
              itemCount: state.images.length,
              constraints: constraints,
              itemBuilder: (context, index) {
                var imageUrl = state.images[index];
                return CardImage(
                  previewImage: imageUrl.previewImageUrl,
                  navigateOnTap: () => Router.goToWidget(
                    context: context,
                    page: ImageViewPage(
                      imageUrl: imageUrl.largeImageUrl,
                    ),
                  ),
                );
              },
            ),
            // Displays loading indicator as the user scrolls downward
            state.hasReachedMax ? Offstage() : LoadMoreIndicator()
          ],
        ),
      );
    } else {
      return NoImages();
    }
  }
}
