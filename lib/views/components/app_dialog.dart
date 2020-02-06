import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:livingwallpaper/views/components/components.dart';

class AppDialog {
  static const platform =
      const MethodChannel('com.annulustek.livingwallpaper/wallpaper');

  static void applyWallpaper({BuildContext context, String imageUrl}) {
    Color color = Theme.of(context).primaryColor;
    TextStyle style = TextStyle(fontSize: 16.0);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Wrap(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                  child: Text(
                    "Set a wallpaper",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, size: 26.0, color: color),
                  title: Text("Home Screen", style: style),
                  onTap: () => _setWallpaper(
                    wallpaperType: 1,
                    largeImageURL: imageUrl,
                    context: context,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.lock, size: 26.0, color: color),
                  title: Text("Lock Screen", style: style),
                  onTap: () => _setWallpaper(
                    wallpaperType: 2,
                    largeImageURL: imageUrl,
                    context: context,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone_android, size: 26.0, color: color),
                  title: Text("Both", style: style),
                  onTap: () => _setWallpaper(
                    wallpaperType: 3,
                    largeImageURL: imageUrl,
                    context: context,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> _setWallpaper(
      {int wallpaperType, String largeImageURL, BuildContext context}) async {
    var file = await DefaultCacheManager().getSingleFile(largeImageURL);
    Navigator.pop(context);
    try {
      await platform.invokeMethod('setWallpaper', [file.path, wallpaperType]);
    } on PlatformException catch (e) {
      print("Failed to Set Wallpaer: '${e.message}'.");
    }
    message(message: "Wallpaper set successfully");
  }
}
