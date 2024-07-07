import 'package:flutter/material.dart';
import '../HomeScreen/HomeScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<Splashscreen> {

  @override
  void initState() {  // Navigation to HomeScreen after splashing out this screen for 4 seconds of duration
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(   // Gradient for screen
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 98, 164, 218),
              Colors.white,
              Color.fromARGB(255, 98, 164, 218),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        width: double.infinity,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(  // Logo and it's Styling
              'assets/images/wwlogo.png',
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),

            const Text(  // App name and Styling
              "WeatherWise",
              style: TextStyle(
                fontSize: 25,
                fontFamily: AutofillHints.addressCity,
                fontWeight: FontWeight.w500,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
