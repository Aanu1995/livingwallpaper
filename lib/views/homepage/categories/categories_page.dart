import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:livingwallpaper/models/categories.dart';
import 'package:livingwallpaper/router/router.dart';
import 'package:livingwallpaper/views/components/card_image.dart';
import 'package:livingwallpaper/views/components/components.dart';
import 'package:livingwallpaper/views/homepage/categories/category_page.dart';
import 'package:livingwallpaper/views/utils/categories_utils.dart';
import 'package:livingwallpaper/views/utils/utils.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final double spacing = 8.0;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    List<Categories> categories = CategoriesUtils.categories;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40.0,
                    child: TextField(
                      cursorColor: primaryColor,
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              searchController.clear();
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16.0),
                        hintText: "Search image",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onSubmitted: (_) => search(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                    color: primaryColor,
                  ),
                  onPressed: () => search(),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 60.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      constraints.maxWidth <= ScreenSizeUtils.maxWidth ? 2 : 3,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 0.80,
                ),
                itemBuilder: (context, index) {
                  var category = categories[index];
                  return CardImage(
                    previewImage: category.image,
                    categoryName: category.category,
                    navigateOnTap: () => onTap(category.category),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  void onTap(String category) async {
    Router.goToWidget(
      context: context,
      page: CategoryBlocProvider(
        category: category,
      ),
    );
  }

  void search() {
    FocusScope.of(context).unfocus();
    String search = searchController.text;
    String text1 = search[0].toUpperCase();
    String text2 = search.substring(1).toLowerCase();
    String currentText = text1 + text2;
    onTap(currentText);
  }
}
