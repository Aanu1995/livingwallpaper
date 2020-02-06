import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:livingwallpaper/controllers/bloc/bloc.dart';
import 'package:livingwallpaper/views/components/components.dart';
import 'package:livingwallpaper/controllers/streams/connectivity_service.dart';
import 'package:livingwallpaper/views/utils/utils.dart';

class CategoryBlocProvider extends StatelessWidget {
  final String category;
  const CategoryBlocProvider({this.category});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryImagesBloc>(
      create: (context) => CategoryImagesBloc()
        ..add(Fetch(imageCategory: category.toLowerCase())),
      child: CategoryPage(category: category),
    );
  }
}

class CategoryPage extends StatefulWidget {
  final String category;
  const CategoryPage({Key key, this.category}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController _scrollController = ScrollController();
  CategoryImagesBloc categoryImagesBloc;
  ImagesLoaded currentState;

  var connectivityProvider;
  String category;

  @override
  void initState() {
    super.initState();
    category = widget.category.toLowerCase();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    categoryImagesBloc = BlocProvider.of<CategoryImagesBloc>(context);
    connectivityProvider = Provider.of<ConnectivityStatus>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category, style: GoogleFonts.montserrat()),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BlocBuilder<CategoryImagesBloc, ImagesState>(
              builder: (context, state) {
                bool status =
                    connectivityProvider == ConnectivityStatus.Offline;
                if (state is ImagesUnInitialized && status) {
                  // Display error messages when the user is offline
                  return (constraints.maxWidth <= ScreenSizeUtils.maxWidth)
                      ? PortraitOffline(onPressed: () => fetch())
                      : LandScapeOffline(onPressed: () => fetch());
                }
                if (state is ImagesLoaded) {
                  // Display widgets when data has been fetched from server
                  currentState = state;
                  return LoadedImages(state, _scrollController, constraints);
                }
                if (state is ImagesError && currentState == null) {
                  // Display error messages when the it couldn't fetch data from server
                  return (constraints.maxWidth <= ScreenSizeUtils.maxWidth)
                      ? PortraitOffline(
                          message: ConstantUtils.poorConnection,
                          onPressed: () => fetch())
                      : LandScapeOffline(
                          message: ConstantUtils.poorConnection,
                          onPressed: () => fetch());
                }
                if (state is ImagesLoading && currentState == null) {
                  return LoadingIndicator();
                }
                return Offstage();
              },
            );
          },
        ),
      ),
    );
  }

  fetch() async {
    if (connectivityProvider != ConnectivityStatus.Offline) {
      categoryImagesBloc.add(Fetch(imageCategory: category));
    }
  }

  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (maxScroll - currentScroll <= 50 &&
        !_scrollController.position.outOfRange) {
      fetch();
    }
  }
}
