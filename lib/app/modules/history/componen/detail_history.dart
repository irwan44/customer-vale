import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/timeline.dart';
import '../../../widgets/widget_timeline_wrapper.dart';
import 'listhistory.dart';

class DetailHistory extends StatefulWidget {
  const DetailHistory({super.key});

  @override
  _DetailHistoryState createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String alamat = arguments['alamat'];
    final String restarea = arguments['nama_cabang'];
    final String namajenissvc = arguments['nama_jenissvc'];
    final String status = arguments['nama_status'];
    final List<dynamic> jasa = arguments['jasa'];
    final List<dynamic> part = arguments['part'];
    Map<String, String> cabangImageAssets = {
      'Bengkelly Rest Area KM 379A': 'assets/logo/379a.jpg',
      'Bengkelly Rest Area KM 228A': 'assets/logo/228a.jpg',
      'Bengkelly Rest Area KM 389B': 'assets/logo/389b.jpg',
      'Bengkelly Rest Area KM 575B': 'assets/logo/575b.jpg',
      'Bengkelly Rest Area KM 319B': 'assets/logo/319b.jpg',
    };
    Color statusColor = StatusColor.getColor(status ?? '');
    String imageAsset = cabangImageAssets[arguments['nama_cabang']] ??
        'assets/logo/logo_vale.png';

    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double padding = screenWidth * 0.02;

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Text(
          'Detail History',
          style: GoogleFonts.nunito(
              color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(children: [
                  ClipOval(
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Service Proses', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold),),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: statusColor,
                            ),
                            child:
                            Text('${status}', style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),),
                          ),
                        ],
                      ),

                      SizedBox(height: 10,),
                      WidgetTimeline(
                        icon: Icons.location_on_rounded,
                        bgcolor: MyColors.appPrimaryColor,
                        title1: restarea,
                        title2: alamat,
                        time: "",
                        showCard: false,
                      ),
                      WidgetTimeline(
                        icon: Icons.note_alt,
                        bgcolor: MyColors.grey,
                        title1: "Detail Jasa",
                        title2: "Jasa Perbaikan Kendaraan",
                        time: "",
                        showCard: true,
                      ),
                      WidgetTimeline(
                        icon: Icons.settings,
                        bgcolor: MyColors.grey,
                        title1: "Detail Part",
                        title2: "Sparepart yang diganti",
                        time: "",
                        showCard2: true,
                      ),
                    ],
                  ),
                ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}