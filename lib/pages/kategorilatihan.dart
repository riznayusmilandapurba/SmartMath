import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmath/pages/mulailatiha12.dart';
import 'package:smartmath/pages/mulailatihan.dart';
import 'package:smartmath/pages/mulailatihan11.dart';

class KategoriLatihan extends StatefulWidget {
  const KategoriLatihan({super.key});

  @override
  State<KategoriLatihan> createState() => _KategoriLatihanState();
}

class _KategoriLatihanState extends State<KategoriLatihan>
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
          'Quiz',
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
              "Latihan Soal",
              style: GoogleFonts.spaceMono(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: 10),
            Text(
              "Pilih sesuai dengan materi yang sudah dipelajari!",
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 175,
              height: 43,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MulaiLatihan10()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Kelas 10',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            SizedBox(
              width: 175,
              height: 43,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MulaiLatihan11()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Kelas 11',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
             SizedBox(height: 35),
            SizedBox(
              width: 175,
              height: 43,
              child: ElevatedButton(
                onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MulaiLatihan12()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Kelas 12',
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
