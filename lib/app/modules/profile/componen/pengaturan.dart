import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../componen/color.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SvgPicture.asset(
            'assets/icons/Successmark.svg',
            width: 100, // Adjust icon size
            height: 100,
          ),
            SizedBox(height: 20,),
            Text('Booking Berhasil', style: GoogleFonts.nunito(fontSize: 25, color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold ),),
            Text('Silakan kembali ke Home', style: GoogleFonts.nunito(fontSize: 17, color: Colors.grey ),),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(right: 30, left: 30),
              child:
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.appPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Kembali Ke Home',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ),
        ],),
      ),
    );
  }
}
