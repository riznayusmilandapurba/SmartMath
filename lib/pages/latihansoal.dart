import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartmath/models/modelLatihan.dart'; 
import 'package:smartmath/models/modelSubmitLatihan.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmath/pages/scorelatihan.dart';

class LatihanSoal extends StatefulWidget {
  final int id_kelas;
  const LatihanSoal({Key? key, required this.id_kelas}) : super(key: key);

  @override
  State<LatihanSoal> createState() => _LatihanSoalState();
}

class _LatihanSoalState extends State<LatihanSoal> {
  int _currentQuestionIndex = 0;
  List<Datum> _questions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    final url = Uri.parse('http://192.168.0.101/smartmath_server/latihanGET.php?id_kelas=${widget.id_kelas}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['isSuccess']) {
        setState(() {
          _questions = List<Datum>.from(data['data'].map((question) => Datum.fromJson(question)));
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitAnswer(String answer, int idLatihan) async {
    final url = Uri.parse('http://192.168.0.101/smartmath_server/user_latihanPOST.php');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_latihan': idLatihan,
        'submission_data': answer,
      }),
    );

    if (response.statusCode == 200) {
      final data = modelSubmitLatihanFromJson(response.body);
      if (data.success) {
        // Handle success response
        print('Jawaban berhasil dikirim');
      } else {
        // Handle error response
        print('Gagal mengirim jawaban: ${data.message}');
      }
    } else {
      // Handle HTTP error
      print('Gagal mengirim jawaban: ${response.statusCode}');
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Jika ini adalah soal terakhir, tampilkan tombol "Finish"
      _submitAnswer(_questions[_currentQuestionIndex].optionA, _questions[_currentQuestionIndex].idLatihan);
      _navigateToScorePage(); // Redirect ke halaman skor setelah selesai
    }
  }

  void _navigateToScorePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScorePage(idKelas: widget.id_kelas)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
        title: Text(
          'Latihan',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _questions.isEmpty
              ? Center(child: Text('Tidak ada soal tersedia'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(184, 232, 147, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_currentQuestionIndex + 1}/${_questions.length}',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _questions[_currentQuestionIndex].soal,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 20),
                            _buildOptionButton('', _questions[_currentQuestionIndex].optionA, _questions[_currentQuestionIndex].idLatihan),
                            _buildOptionButton('', _questions[_currentQuestionIndex].optionB, _questions[_currentQuestionIndex].idLatihan),
                            _buildOptionButton('', _questions[_currentQuestionIndex].optionC, _questions[_currentQuestionIndex].idLatihan),
                            _buildOptionButton('', _questions[_currentQuestionIndex].optionD, _questions[_currentQuestionIndex].idLatihan),
                            _buildOptionButton('', _questions[_currentQuestionIndex].optionE, _questions[_currentQuestionIndex].idLatihan),
                            SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: _nextQuestion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _currentQuestionIndex < _questions.length - 1 ? Colors.grey : Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  _currentQuestionIndex < _questions.length - 1 ? 'Next' : 'Finish',
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
                    ],
                  ),
                ),
    );
  }

  Widget _buildOptionButton(String label, String text, int idLatihan) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _submitAnswer(text, idLatihan);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(252, 251, 251, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            '$label. $text',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}


