import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:livingwallpaper/controllers/bloc/bloc.dart';
import 'package:livingwallpaper/views/components/components.dart';
import 'package:livingwallpaper/controllers/streams/connectivity_service.dart';
import 'package:livingwallpaper/views/utils/utils.dart';

class AllWallpapersPage extends StatefulWidget {
  const AllWallpapersPage({Key key}) : super(key: key);

  @override
  _AllWallpapersPageState createState() => _AllWallpapersPageState();
}

class _AllWallpapersPageState extends State<AllWallpapersPage> {
  final ScrollController _scrollController = ScrollController();

  AllImagesBloc allImagesBloc;
  ImagesLoaded currentState;

  var connectivityProvider;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    allImagesBloc = BlocProvider.of<AllImagesBloc>(context);
    connectivityProvider = Provider.of<ConnectivityStatus>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocBuilder<AllImagesBloc, ImagesState>(
          builder: (context, state) {
            bool status = connectivityProvider == ConnectivityStatus.Offline;
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
    );
  }

  fetch() async {
    if (connectivityProvider != ConnectivityStatus.Offline) {
      allImagesBloc.add(Fetch());
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
