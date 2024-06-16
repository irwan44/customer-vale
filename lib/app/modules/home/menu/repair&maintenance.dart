import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RepairMaintenance extends StatefulWidget {
  const RepairMaintenance({super.key});

  @override
  State<RepairMaintenance> createState() => _RepairMaintenanceState();
}

class _RepairMaintenanceState extends State<RepairMaintenance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: const Text('ChatView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChatView is working',
          style: GoogleFonts.nunito(fontSize: 20),
        ),
      ),
    );
  }
}
