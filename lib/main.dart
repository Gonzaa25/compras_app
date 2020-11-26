import 'package:compras_app/providers/page_provider.dart';
import 'package:compras_app/providers/shoppinglist_provider.dart';
import 'package:compras_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:compras_app/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ListaProvider()),
        ChangeNotifierProvider(create: (context) => PageProvider())
      ],
      builder: (context, child) {
        final themestate = context.watch<ThemeProvider>();
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: themestate.usedarktheme
              ? ThemeData(
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.blue,
                  ),
                  textTheme: TextTheme(
                      headline1: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      subtitle1: TextStyle(color: Colors.grey),
                      subtitle2: TextStyle(color: Colors.black,fontSize: 18)),
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                )
              : ThemeData(
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.blue,
                  ),
                  textTheme: TextTheme(
                      headline1: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      subtitle1: TextStyle(color: Colors.grey),
                      subtitle2: TextStyle(color: Colors.black,fontSize: 17)),
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
          home: HomePage(title: 'Mis listas de compras'),
        );
      },
    );
  }
}
