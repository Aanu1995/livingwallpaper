import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:content_placeholder/content_placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:livingwallpaper/views/components/empty_space.dart';

class CardImage extends StatelessWidget {
  final String previewImage;
  final void Function() navigateOnTap;

  final String categoryName;
  const CardImage(
      {Key key, this.navigateOnTap, this.previewImage = "", this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 1.0,
            child: categoryName == null
                ? CachedNetworkImage(
                    imageUrl: previewImage,
                    placeholder: (context, value) {
                      return ContentPlaceholder(
                        spacing: EdgeInsets.all(0.0),
                      );
                    },
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    previewImage,
                    fit: BoxFit.cover,
                  ),
          ),
          categoryName == null
              ? Offstage()
              : Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black12,
                          Colors.black45,
                          Colors.black87
                        ],
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            categoryName,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ).copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        EmptySpace(multiple: 1.5, horizontal: true),
                        Icon(Icons.chevron_right, color: Colors.white)
                      ],
                    ),
                  ),
                )
        ],
      ),
      onTap: navigateOnTap,
    );
  }
}
