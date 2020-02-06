import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livingwallpaper/controllers/bloc/bloc.dart';
import 'package:provider/provider.dart';
import 'package:livingwallpaper/controllers/streams/connectivity_service.dart';

class BaseProvider extends StatelessWidget {
  final Widget child;
  const BaseProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          initialData: ConnectivityStatus.Cellular,
          create: (_) =>
              ConnectivityService().connectionStatusController.stream,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AllImagesBloc>(
            create: (context) => AllImagesBloc()..add(Fetch()),
          ),
        ],
        child: child,
      ),
    );
  }
}
