import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:livingwallpaper/controllers/streams/connectivity_service.dart';
import 'package:livingwallpaper/views/homepage/all_wallpapers_page.dart';
import 'package:livingwallpaper/views/homepage/categories/categories_page.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Living Wallpapers", style: GoogleFonts.montserrat()),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text("ALL WALLPAPERS",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
              ),
              Tab(
                child: Text("CATEGORIES",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  const AllWallpapersPage(),
                  const CategoriesPage(),
                ],
              ),
            ),
            // The widget below displays 'No connection' when the user is offline
            Offline(),
          ],
        ),
      ),
    );
  }
}

class Offline extends StatelessWidget {
  const Offline({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer<ConnectivityStatus>(
        builder: (context, conn, _) {
          if (conn == ConnectivityStatus.Offline) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              color: Theme.of(context).primaryColor,
              width: double.maxFinite,
              child: Text(
                "No connection",
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Colors.white),
              ),
            );
          } else {
            return Offstage();
          }
        },
      ),
    );
  }
}
