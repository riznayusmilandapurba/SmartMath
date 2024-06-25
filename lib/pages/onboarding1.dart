import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmath/pages/onboarding2.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 106),
            Center(
              child: Image.asset(
                'images/1.png',
                width: 312,
                height: 304,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Selamat Datang di",
                style: GoogleFonts.hindGuntur(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                "SmartMath",
                style: GoogleFonts.hindGuntur(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: GoogleFonts.hindGuntur(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 100),
            Center(
              child: SizedBox(
                width: 287,
                height: 38,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OnBoarding2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(80, 190, 91, 0.86), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50), // Add extra spacing at the bottom
          ],
        ),
      ),
    );
  }
}
