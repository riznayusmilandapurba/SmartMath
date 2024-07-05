import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmath/models/modelverified.dart';
import 'package:smartmath/pages/login.dart'; // Sesuaikan dengan lokasi halaman Login

class VerificationPage extends StatefulWidget {
  final String email;

  const VerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  List<String> pin = ["", "", "", ""];

  TextEditingController pinController1 = TextEditingController();
  TextEditingController pinController2 = TextEditingController();
  TextEditingController pinController3 = TextEditingController();
  TextEditingController pinController4 = TextEditingController();

  int _countdown = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    sendEmail();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_countdown == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  Future<void> sendEmail() async {
    try {
      http.Response res;
      Map<String, String> requestBody = {"email": widget.email};
      Uri url = Uri.parse('http://192.168.0.101/smartmath_server/send_verification_code.php');
      res = await http.post(url, body: requestBody);
      print("RESPONSE BODY: ${res.body}");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> verifEmail() async {
    try {
      http.Response res;
      String verificationCode =
          "${pinController1.text}${pinController2.text}${pinController3.text}${pinController4.text}";
      Map<String, String> requestBody = {
        "email": widget.email,
        "verification_code": verificationCode
      };
      Uri url = Uri.parse('http://192.168.0.101/smartmath_server/verified_code.php');
      res = await http.post(url, body: requestBody);
      print("RESPONSE BODY: ${res.body}");
      
      if (res.statusCode == 200) {
        var data = modelVerifiedFromJson(res.body);
        
        if (data.value == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()), // Ganti dengan halaman login Anda
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Kode verifikasi salah')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memverifikasi email')),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Verifikasi Akun',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Image.asset(
              'images/4.png',
              height: 107,
              width: 154,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Kode verifikasi telah dikirim ke ${widget.email}",
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildPinInput(context, pinController1),
                        SizedBox(width: 8),
                        buildPinInput(context, pinController2),
                        SizedBox(width: 8),
                        buildPinInput(context, pinController3),
                        SizedBox(width: 8),
                        buildPinInput(context, pinController4),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (_countdown == 0) {
                        _countdown = _countdown + 60;
                        sendEmail();
                        _startTimer(); // Start the timer again
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: _countdown != 0 ? 'Kirim ulang dalam ' : '',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: _countdown != 0 ? '$_countdown' : 'Kirim Ulang Kode',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: _countdown != 0 ? 's' : '',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      verifEmail();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Verifikasi',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
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

  Widget buildPinInput(BuildContext context, TextEditingController controller) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
