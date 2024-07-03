import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MulaiLatihan12 extends StatefulWidget {
  const MulaiLatihan12({super.key});

  @override
  State<MulaiLatihan12> createState() => _MulaiLatihan12State();
}

class _MulaiLatihan12State extends State<MulaiLatihan12>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
        title: Text(
          'Latihan',
          style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.headline6,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Latihan Soal Untuk Kelas 12",
              style: GoogleFonts.spaceMono(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(
              "Soal berisi materi yang sudah dibahas sebelumnya",
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Number of Questions : 10",
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 70),
            SizedBox(
              width: 175,
              height: 43,
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 16,
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
