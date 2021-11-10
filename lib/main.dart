import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import 'providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProductsProvider(),
      child: MaterialApp(
        title: 'myShop',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
              .copyWith(secondary: Colors.limeAccent),
        ),
        home: ProductsOverviewScreen(),
        routes: {ProductDetailScreen.routeName: (ctx) => ProductDetailScreen()},
      ),
    );
  }
}
