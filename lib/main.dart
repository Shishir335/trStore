import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/api_service/api_service.dart';
import 'package:tr_store/providers/cart_provider.dart';
import 'package:tr_store/screens/cart_screen.dart';
import 'package:tr_store/utils/colors.dart';
import 'package:tr_store/screens/home_screen.dart';
import 'package:tr_store/providers/products_provider.dart';
import 'package:tr_store/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => ProductProvider(apiService: ApiService())),
    ChangeNotifierProvider(create: (context) => CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TR Store',
      home: const SplashScreen(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white)),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        CartScreen.routeName: (context) => const CartScreen(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
