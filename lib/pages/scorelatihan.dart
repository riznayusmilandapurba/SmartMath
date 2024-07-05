import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmath/pages/kategorilatihan.dart';
import 'package:smartmath/pages/mulailatihan.dart';

class ScorePage extends StatefulWidget {
  final int idKelas;

  const ScorePage({Key? key, required this.idKelas}) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  String _totalScore = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchScore();
  }

  Future<void> _fetchScore() async {
    final url = Uri.parse('http://192.168.0.101/smartmath_server/scoreGET.php');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'id_kelas': widget.idKelas.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data.containsKey('total_score')) {
          setState(() {
            _totalScore = data['total_score'].toString();
          });
        } else {
          setState(() {
            _totalScore = 'Failed to fetch score';
          });
          print('Failed: ${data['message']}'); // Menambahkan log kesalahan
        }
      } else {
        setState(() {
          _totalScore = 'Failed to fetch score';
        });
        print('Failed to fetch score: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _totalScore = 'Failed to connect to server';
      });
      print('Error: $e'); // Menambahkan log kesalahan
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
        title: Text(
          'Score Latihan',
          style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.headline6!,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 223,
              left: 16,
              right: 16,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(171, 191, 184, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'YOUR SCORE IS',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _totalScore,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => KategoriLatihan()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(184, 232, 147, 1),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          child: Text('FINISH'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                         onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MulaiLatihan10()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(184, 232, 147, 1),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          child: Text('TRY AGAIN'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
             Positioned(
              top: 210,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 25,
                  width: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(184, 232, 147, 1),
                  ),
                  child: Center(
                    child: Text(
                      'CONGRATULATIONS!!!!',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
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
