import 'package:flutter/material.dart';
import 'package:livingwallpaper/views/components/empty_space.dart';
import 'package:livingwallpaper/views/utils/constants.dart';

class PortraitOffline extends StatelessWidget {
  final String message;
  final void Function() onPressed;
  final Color textColor;
  const PortraitOffline({Key key, this.message, this.onPressed, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              message == null ? "assets/error.jpg" : "assets/error2.jpg",
            ),
            EmptySpace(multiple: 3.0),
            Column(
              children: <Widget>[
                Text(
                  message ?? ConstantUtils.offline,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.subhead.fontSize,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                      color: textColor ?? primaryColor),
                ),
                EmptySpace(multiple: 3.0),
                FlatButton(
                  color: textColor ?? primaryColor.withOpacity(0.7),
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Retry",
                    style: Theme.of(context).textTheme.subhead.copyWith(
                          color:
                              textColor == null ? Colors.white : primaryColor,
                        ),
                  ),
                  onPressed: onPressed,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LandScapeOffline extends StatelessWidget {
  final String message;
  final void Function() onPressed;
  const LandScapeOffline({Key key, this.onPressed, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.asset(
                message == null ? "assets/error.jpg" : "assets/error2.jpg",
              ),
            ),
            EmptySpace(horizontal: true),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    message ?? ConstantUtils.offline,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: Theme.of(context).textTheme.subhead.fontSize,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: primaryColor),
                  ),
                  EmptySpace(multiple: 3.0),
                  FlatButton(
                    color: primaryColor.withOpacity(0.7),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Retry",
                      style: Theme.of(context).textTheme.subhead.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    onPressed: onPressed,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
