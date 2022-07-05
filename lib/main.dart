import 'package:flutter/material.dart';
import 'package:myappappsa/data/datasources/local/cache/app_cache.dart';
import 'package:myappappsa/presentations/features/cart/cart_page.dart';
import 'package:myappappsa/presentations/features/home/home_page.dart';
import 'package:myappappsa/presentations/features/sign_in/sign_in_page.dart';
import 'package:myappappsa/presentations/features/sign_up/sign_up_page.dart';
import 'package:myappappsa/presentations/features/splash/splasd_page.dart';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: {
        "/sign-in": (context) => const SignInPage(),
        "/sign-up": (context) => const SignUpPage(),
        "/home": (context) => const HomePage(),
        "/": (context) =>  const SplashPage(),
        "/cart": (context) => const CartPage(),
      },
      initialRoute: "/",
    );
  }
}

