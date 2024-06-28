import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/collection_list.dart';
import 'package:grocycart/consts/color_list.dart';
import 'package:grocycart/consts/theme_provider.dart';
import '../../widgets/app_routes.dart';
import 'CategoriesWidgets/category_widgets.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  static const String routeName = '/categories';
  const CategoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.read(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: GridView.count(
        childAspectRatio: 180 / 170,
        crossAxisCount: 2,
        children: List.generate(collectionList.length, (index) {
          return CategoryContainer(
            title: collectionList[index].name,
            isDarkTheme: isDarkTheme,
            imageLink: collectionList[index].imageUrl,
            color: colorList[index + 10],
            onTap: () {
              navigateToPusNamed(context, AppRoutes.categoryProductScreen,
                  arguments: collectionList[index]);
            },
          );
        }),
      ),
    );
  }
}
