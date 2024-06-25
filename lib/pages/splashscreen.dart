import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smartmath/pages/onboarding1.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnBoarding1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(80, 190, 91, 0.86),
              Color.fromRGBO(80, 190, 91, 0.86),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 290,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "SmartMath",
                  style: GoogleFonts.inter(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 333,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Learn from everywhere",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
