import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartmath/pages/profile_info.dart';
import 'package:smartmath/utils/session_manager.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _fullnameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fullnameController = TextEditingController(text: sessionManager.fullname ?? '');
    _phoneController = TextEditingController(text: sessionManager.phone ?? '');
    _addressController = TextEditingController(text: sessionManager.address ?? '');
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    if (keyForm.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // Simpan perubahan ke sessionManager
      sessionManager.fullname = _fullnameController.text;
      sessionManager.phone = _phoneController.text;
      sessionManager.address = _addressController.text;

      try {
        // Simpan perubahan ke server atau penyimpanan eksternal lainnya (jika diperlukan)
        await sessionManager.saveSession(
          1, // Misalnya, nilai value diset tetap 1
          sessionManager.id_user ?? 0, // Pastikan menggunakan idUser, sesuaikan dengan yang digunakan di aplikasi
          sessionManager.fullname ?? '',
          sessionManager.email ?? '',
          sessionManager.phone ?? '',
          sessionManager.address ?? '',
        );

        // Navigasi kembali ke halaman ProfileInfo setelah berhasil disimpan
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileInfo()),
        );
      } catch (error) {
        print('Error saving profile changes: $error');
        // Handle error state if needed
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.headline6,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 67),
                Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _fullnameController,
                        decoration: InputDecoration(
                          hintText: 'Input Username',
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Asal Sekolah',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          hintText: 'Input Asal Sekolah',
                          prefixIcon: Icon(
                            Icons.school_outlined,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your school name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Phone Number',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: 'Input Phone Number',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 100),
                      Center(
                        child: SizedBox(
                          width: 287,
                          height: 38,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _saveChanges,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(80, 190, 91, 0.86),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  )
                                : Text(
                                    'Confirm Edit',
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
        ),
      ),
    );
  }
}
