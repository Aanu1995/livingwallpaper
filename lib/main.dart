import 'package:flutter/material.dart';
import 'package:livingwallpaper/controllers/providers/base_provider.dart';
import 'package:livingwallpaper/router/routes.dart';
import 'package:livingwallpaper/views/utils/color_utils.dart';

void main() => runApp(BaseProvider(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Living Wallpapers',
      theme: ThemeData(
        primaryColor: ColorUtils.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoutes,
    );
  }
}
