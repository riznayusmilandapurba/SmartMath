import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PolicyLegacy extends StatefulWidget {
  const PolicyLegacy({super.key});

  @override
  State<PolicyLegacy> createState() => _PolicyLegacyState();
}

class _PolicyLegacyState extends State<PolicyLegacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Info',
          style: GoogleFonts.inter(
            textStyle: Theme.of(context).textTheme.headline6,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Legal',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eu scelerisque felis imperdiet proin fermentum leo. Ac felis donec et odio pellentesque diam. Ornare aenean euismod elementum nisi quis eleifend quam. Lacus suspendisse faucibus interdum posuere lorem ipsum. Nibh venenatis cras sed felis eget velit aliquet sagittis id. Enim praesent elementum facilisis leo vel. Sit amet mattis vulputate enim nulla. Massa tincidunt dui ut ornare. Odio aenean sed adipiscing diam donec adipiscing.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              'Policy',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eu scelerisque felis imperdiet proin fermentum leo. Ac felis donec et odio pellentesque diam. Ornare aenean euismod elementum nisi quis eleifend quam. Lacus suspendisse faucibus interdum posuere lorem ipsum. Nibh venenatis cras sed felis eget velit aliquet sagittis id. Enim praesent elementum facilisis leo vel. Sit amet mattis vulputate enim nulla. Massa tincidunt dui ut ornare. Odio aenean sed adipiscing diam donec adipiscing.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
