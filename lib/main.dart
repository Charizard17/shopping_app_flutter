import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/cart.dart';
import './providers/products.dart';
import './providers/orders.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'myShop',
        theme: ThemeData(
          // fontFamily: 'Lato', // fonts throw an error...
          primaryColor: Color(0xFF133AAC),
          accentColor: Color(0xFFFFC340),
          errorColor: Color(0xFFFF1B1C),
          appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFF133AAC),
              titleTextStyle: TextStyle(
                color: Color(0xFFFFC340),
                fontSize: 20
              )),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
