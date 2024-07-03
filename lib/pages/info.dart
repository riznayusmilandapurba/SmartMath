import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartmath/pages/kategorilatihan.dart';
import 'package:smartmath/pages/login.dart';
import 'package:smartmath/pages/mulailatihan.dart';
import 'package:smartmath/pages/policy_legacy.dart';
import 'package:smartmath/pages/profile_info.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> with SingleTickerProviderStateMixin {
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
        title: Text(
          'Info',
          style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.headline6,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width * 0.5 - 175, // Center horizontally
            child: Container(
              width: 350,
              height: 205,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                border: Border.all(color: Colors.black),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileInfo()),
                  );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profil Info',
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.subtitle1,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                          ),
                        ),
                       
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PolicyLegacy()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Privacy & Policy',
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.subtitle1,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                          ),
                        ),
                        
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Logout',
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context).textTheme.subtitle1,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.red,
                          ),
                        ),
                       
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color: Colors.white,
        child: Container(
          height: 89,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(builder: (context) => MulaiBelajar()),
                  // );
                },
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.graduationCap,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KategoriLatihan()),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.lightbulb_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => RobotSoal()),
                  // );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color : Color.fromRGBO(80, 190, 91, 0.86),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Info()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}