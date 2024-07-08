import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smartmath/models/modelQuiz.dart';

class QuizPage extends StatefulWidget {
  final String idMateri; // Anda perlu menentukan idMateri yang dipilih untuk mengambil quiz-nya

  QuizPage({required this.idMateri});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<ModelQuiz> quizzes = [];
  late List<String> quizAnswers = [];
  bool showScoreModal = false;
  double userScore = 0; // Variabel untuk menyimpan skor pengguna

  @override
  void initState() {
    super.initState();
    fetchQuizData();
  }

  Future<void> fetchQuizData() async {
    final response = await http.get(Uri.parse('http://192.168.0.101/smartmath_server/quiz.php?id_materi=${widget.idMateri}'));

    if (response.statusCode == 200) {
      setState(() {
        quizzes = modelQuizFromJson(response.body);
        quizAnswers = List.filled(quizzes.length, '');
      });
    } else {
      throw Exception('Failed to load quiz');
    }
  }

  Future<void> submitQuizAnswer(String idQuiz, String answer) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.101/smartmath_server/userQuizPost.php'),
      body: jsonEncode({
        'id_quiz': idQuiz,
        'submission_data': answer,
        // Ganti dengan id_user yang sesuai dari session login
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle successful submission
      print('Quiz answer submitted successfully');
      // Anda bisa menambahkan feedback atau notifikasi di sini jika diperlukan
    } else {
      // Handle errors
      print('Failed to submit quiz answer');
    }
  }

  Future<void> fetchQuizScore(String idQuiz) async {
    try {
      final response = await http.get(Uri.parse('http://192.168.0.101/smartmath_server/scoreQuizGet.php?id_quiz=$idQuiz'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('data')) {
          setState(() {
            userScore = data['data']['total_score'];
            showScoreModal = true;
          });
        } else {
          throw Exception('Score data not found in response');
        }
      } else {
        throw Exception('Failed to load quiz score');
      }
    } catch (e) {
      print('Error fetching quiz score: $e');
      // Tambahkan penanganan error sesuai kebutuhan Anda di sini
    }
  }


  void showScoreModalDialog() {
    // Pastikan semua jawaban sudah di-submit sebelum menampilkan skor
    if (quizAnswers.contains('')) {
      print('Please answer all questions before checking the score.');
      return;
    }

    // Ambil idQuiz dari salah satu quiz (misalnya dari quizzes[0] jika ada)
    String idQuiz = quizzes.isNotEmpty ? quizzes[0].idQuiz : '';

    // Panggil fungsi untuk mengambil skor
    fetchQuizScore(idQuiz);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.green,
      ),
      body: quizzes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.questions,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Your Answer',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      quizAnswers[index] = value;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      submitQuizAnswer(quiz.idQuiz, quizAnswers[index]);
                    },
                    child: Text('Submit Answer'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showScoreModalDialog();
        },
        child: Icon(Icons.assignment_turned_in),
        backgroundColor: Colors.green,
      ),
      // Modal untuk menampilkan skor
      bottomSheet: showScoreModal
          ? Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your score: ${userScore.toStringAsFixed(1)}', // Tampilkan skor di sini
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showScoreModal = false;
                });
              },
              child: Text('Close'),
            ),
          ],
        ),
      )
          : null,
    );
  }
}