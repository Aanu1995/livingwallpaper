import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.red),
        ),
      ),
    );
  }
}

class LoadMoreIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      width: double.maxFinite,
      child: Center(
        child: SizedBox(
          height: 30.0,
          width: 30.0,
          child: CircularProgressIndicator(strokeWidth: 2.0),
        ),
      ),
    );
  }
}

void message({String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: 1,
    backgroundColor: Colors.white,
    textColor: Colors.black,
    fontSize: 16.0,
  );
}
