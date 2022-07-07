import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myappappsa/common/constants/variable_constant.dart';
import 'package:myappappsa/data/datasources/local/cache/app_cache.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);


  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 2),() {
      String token = AppCache.getString(VariableConstant.TOKEN);
      // print("token: $token");
      if (token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/sign-in');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset('assets/animations/23211-receive-order.json',
                animate: true, repeat: true),
            const Text("Welcome",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white))
          ],
        ));
  }
}