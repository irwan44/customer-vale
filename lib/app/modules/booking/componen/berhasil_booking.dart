import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../componen/color.dart';

class SuksesBooking extends StatefulWidget {
  const SuksesBooking({super.key});

  @override
  State<SuksesBooking> createState() => _SuksesBookingState();
}

class _SuksesBookingState extends State<SuksesBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        toolbarHeight: 0,),
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
