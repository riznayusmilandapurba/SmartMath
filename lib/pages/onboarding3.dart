import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmath/pages/onboarding3.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({super.key});

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 106),
            Center(
              child: Image.asset(
                'images/3.png',
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
                      MaterialPageRoute(builder: (context) => OnBoarding3()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Sign Up Now',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  
                },
                child: Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue, 
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
