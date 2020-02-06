import 'package:flutter/material.dart';
import 'package:livingwallpaper/views/utils/utils.dart';

class GridViewCardImage extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final BoxConstraints constraints;
  const GridViewCardImage({
    Key key,
    this.itemCount,
    this.itemBuilder,
    this.constraints,
  }) : super(key: key);

  final double spacing = 8.0;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            constraints.maxWidth <= ScreenSizeUtils.maxWidth ? 2 : 3,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 0.65,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
