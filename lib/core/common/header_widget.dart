import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final String headName;
  const HeaderWidget({super.key, required this.headName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(radius: 18, backgroundColor: Colors.black, child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18)),
            ),
            // IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_basket_rounded, size: 32, color: Colors.black)),
          ],
        ),
        const SizedBox(height: 10),
        Text(headName, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
      ],
    );
  }
}
