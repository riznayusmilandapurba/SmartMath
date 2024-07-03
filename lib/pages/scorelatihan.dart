import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

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
    final url = Uri.parse('http://192.168.0.101/smartmath_server/scoreGET.php?id_kelas=${widget.idKelas}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _totalScore = data['success'] ? data['total_score'] : 'Failed to fetch score';
      });
    } else {
      setState(() {
        _totalScore = 'Failed to fetch score';
      });
    }
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
              "Score Latihan",
              style: GoogleFonts.spaceMono(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _totalScore,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
