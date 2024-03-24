import 'package:Laurent/screens/auth/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
            // add style to text
            child: AnimatedSplashScreen(
                duration: 4000,
                splash: Image.asset(
                    'assets/logo_laurent.png',
                    width: 600,
                    height: 600,),
                nextScreen: LoginScreen(),
                splashTransition: SplashTransition.fadeTransition,
                backgroundColor: Colors.white)),
      ),
    );
  }
}
