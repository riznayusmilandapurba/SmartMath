import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartmath/models/modelLatihan.dart'; // Sesuaikan dengan path file model_latihan.dart Anda

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
    final url = Uri.parse('http://192.168.0.100/smartmath_server/latihanGET.php?id_kelas=${widget.id_kelas}');
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

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
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
          style: TextStyle(
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
                      Text(
                        _questions[_currentQuestionIndex].soal,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          _buildOptionButton('A', _questions[_currentQuestionIndex].optionA),
                          _buildOptionButton('B', _questions[_currentQuestionIndex].optionB),
                          _buildOptionButton('C', _questions[_currentQuestionIndex].optionC),
                          _buildOptionButton('D', _questions[_currentQuestionIndex].optionD),
                          _buildOptionButton('E', _questions[_currentQuestionIndex].optionE),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
                    ],
                  ),
                ),
    );
  }

  Widget _buildOptionButton(String label, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Handle answer selection
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            '$label. $text',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
