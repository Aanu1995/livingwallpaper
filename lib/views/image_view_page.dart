import 'package:cached_network_image/cached_network_image.dart';
import 'package:content_placeholder/content_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:livingwallpaper/views/components/app_dialog.dart';
import 'package:livingwallpaper/views/components/empty_space.dart';

import 'components/components.dart';

class ImageViewPage extends StatefulWidget {
  final String imageUrl;
  const ImageViewPage({Key key, this.imageUrl = ""}) : super(key: key);

  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  bool isImageDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.imageUrl,
            placeholder: (context, value) {
              return ContentPlaceholder();
            },
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 40.0,
            left: 16.0,
            right: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ActionButton(
                  icon: Icons.close,
                  onTap: () => Navigator.pop(context),
                ),
                Row(
                  children: <Widget>[
                    ActionButton(
                      icon: Icons.file_download,
                      size: 25.0,
                      onTap: () async {
                        setState(() {
                          isImageDownloading = true;
                        });
                        await ImageDownloader.downloadImage(widget.imageUrl);
                        setState(() {
                          isImageDownloading = false;
                        });
                        message(message: "Image downloaded successfully");
                      },
                    ),
                    EmptySpace(horizontal: true, multiple: 2.5),
                    ActionButton(
                        icon: Icons.done,
                        onTap: () {
                          AppDialog.applyWallpaper(
                            context: context,
                            imageUrl: widget.imageUrl,
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
          if (isImageDownloading)
            Center(
              child: SpinKitDualRing(
                color: Theme.of(context).primaryColor,
              ),
            )
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final void Function() onTap;
  const ActionButton({this.icon, this.onTap, this.size = 28.0});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.black12,
        child: Icon(icon, size: size, color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
