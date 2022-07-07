import 'package:flutter/material.dart';
import '../../../data/datasources/local/cache/app_cache.dart';
import '../../../presentation/features/cart/cart_page.dart';
import '../../../presentation/features/home/home_page.dart';
import '../../../presentation/features/order_history/order_history_page.dart';
import '../../../presentation/features/sign_in/sign_in_page.dart';
import '../../../presentation/features/sign_up/sign_up_page.dart';
import '../../../presentation/features/splash/splash_page.dart';
void main() async {
  runApp(MyApp());
  await AppCache.init();
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "QuickSan",
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/sign-in": (context) => SignInPage(),
        "/sign-up": (context) => SignUpPage(),
        "/home": (context) => HomePage(),
        "/cart": (context) => CartPage(),
        "/order-history": (context) => OrderHistoryPage(),
        "/": (context) => SplashPage(),
      },
      initialRoute: "/",
    );
  }
}
