import 'package:flutter/material.dart';
import 'package:livingwallpaper/views/homepage/home_page.dart';
import 'package:livingwallpaper/views/image_view_page.dart';

class Routes {
  static const String INITIALPAGE = "/";
  static const String HOMEPAGE = "/homepage";
  static const String IMAGEVIEWPAGE = "/imageviewpage";

  static Map<String, Widget Function(BuildContext)> get getRoutes => {
        INITIALPAGE: (BuildContext context) => Homepage(),
        HOMEPAGE: (BuildContext context) => Homepage(),
        IMAGEVIEWPAGE: (BuildContext context) => ImageViewPage(),
      };
}
