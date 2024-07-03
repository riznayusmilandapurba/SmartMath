import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:smartmath/models/modelRegister.dart';
import 'package:smartmath/pages/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isUsernameValid = false;
  bool isPhoneNumberValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isPasswordVisible = false;
  TextEditingController txtFullname = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtAddress = TextEditingController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> registerAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(
        Uri.parse('http://192.168.1.3/smartmath_server/register.php'),
        body: {
          "fullname": txtFullname.text,
          "password": txtPassword.text,
          "email": txtEmail.text,
          "phone": txtPhone.text,
          "address": txtAddress.text,
        },
      );

      ModelRegister data = modelRegisterFromJson(res.body.trim());

      // Check response value
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data.message)),
      );

      if (data.value == 1) {
        // Registration successful, navigate to login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (route) => false,
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
                  'Create Account',
                  style: GoogleFonts.hindGuntur(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 140),
                    Form(
                      key: keyForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: GoogleFonts.inter(
                              textStyle: Theme.of(context).textTheme.displayLarge,
                              fontSize: 16,
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
                              controller: txtFullname,
                              onChanged: (value) {
                                setState(() {
                                  isUsernameValid = value.isNotEmpty;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Input Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.black,
                                ),
                                suffixIcon: isUsernameValid
                                    ? Icon(Icons.check_circle_outline,
                                        color: Color.fromRGBO(80, 190, 91, 0.86))
                                    : null,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                          ),
                          
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          Text(
                            'Password',
                            style: GoogleFonts.inter(
                              textStyle: Theme.of(context).textTheme.displayLarge,
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
                          SizedBox(height: 20),
                          Text(
                            'Asal Sekolah',
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
                              controller: txtAddress,
                              onChanged: (value) {
                                setState(() {
                                  isEmailValid = value.isNotEmpty;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Input Asal Sekolah',
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
                                  Icons.home_outlined,
                                  color: Colors.black,
                                ),
                                suffixIcon: isEmailValid
                                    ? Icon(Icons.check_circle_outline,
                                        color: Colors.blue)
                                    : null,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Phone Number',
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
                              controller: txtPhone,
                              onChanged: (value) {
                                setState(() {
                                  isPhoneNumberValid = value.isNotEmpty;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Input Phone Number',
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
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                suffixIcon: isPhoneNumberValid
                                    ? Icon(Icons.check_circle_outline,
                                        color: Colors.blue)
                                    : null,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 100),
                          Center(
                            child: SizedBox(
                              width: 287,
                              height: 38,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (keyForm.currentState?.validate() == true) {
                                    registerAccount();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(80, 190, 91, 0.86),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
