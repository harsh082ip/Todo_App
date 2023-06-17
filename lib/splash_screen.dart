import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/images/logo5.png',
            width: 220,
          ),
          const SizedBox(
            height: 45,
          ),
          const Text(
            'TODO Application',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const CircularProgressIndicator(
            color: Colors.lightBlue,
          ),
        ]),
      ),
    );
  }
}
