import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmath/models/modelLogin.dart';
import 'package:smartmath/pages/Homepage.dart';
import 'package:smartmath/pages/info.dart';
import 'package:smartmath/pages/register.dart';
import 'package:flutter/gestures.dart';  
import 'package:http/http.dart' as http;
import 'package:smartmath/utils/session_manager.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isPasswordVisible = false;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(
        Uri.parse('http://192.168.1.3/smartmath_server/login.php'),
        body: {
          "email": txtEmail.text,
          "password": txtPassword.text,
        },
      );

      ModelLogin data = modelLoginFromJson(res.body.trim());

      if (data.value == 1) {
        await sessionManager.saveSession(
          data.value ?? 0,
          data.id_user ?? 0,
          data.fullname ?? "",
          data.email ?? "",
          data.phone ?? "",
          data.address ?? "",
        );
        print('Session Saved');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );

        print('Navigating to Home');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => false,
        );
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.message}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 17,
                left: 13,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_circle_left),
                  color: Color.fromRGBO(80, 190, 91, 0.86),
                  iconSize: 30,
                ),
              ),
              Positioned(
                top: 82,
                left: 22,
                child: Text(
                  'Login Account',
                  style: GoogleFonts.hindGuntur(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 140),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        Form(
                          key: keyForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: GoogleFonts.openSans(
                                  textStyle: Theme.of(context).textTheme.displayLarge,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: txtEmail,
                                  onChanged: (value) {
                                    setState(() {
                                      isEmailValid = value.isNotEmpty;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Input Email',
                                    hintStyle: TextStyle(
                                      color: Color.fromRGBO(130, 130, 130, 1),
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.black,
                                    ),
                                    suffixIcon: isEmailValid
                                        ? Icon(Icons.check_circle_outline,
                                            color: Colors.blue)
                                        : null,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: txtPassword,
                                onChanged: (value) {
                                  setState(() {
                                    isPasswordValid = value.isNotEmpty;
                                  });
                                },
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: 'Input Password',
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(130, 130, 130, 1),
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_clock_outlined,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 100),
                        Center(
                          child: SizedBox(
                            width: 287,
                            height: 38,
                            child: ElevatedButton(
                              onPressed: () {
                                if (keyForm.currentState!.validate()) {
                                  loginAccount();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please enter both email and password'),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(80, 190, 91, 0.86),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Sign In',
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
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
