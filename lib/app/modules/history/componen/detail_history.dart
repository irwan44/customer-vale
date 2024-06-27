import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../componen/color.dart';
import '../../../data/data_endpoint/generalcekup.dart';
import '../../../data/endpoint.dart';
import '../../../widgets/timeline.dart';
import '../../../widgets/timeline_title.dart';
import '../../../widgets/widget_timeline_wrapper.dart';
import 'listhistory.dart';

class DetailHistory extends StatefulWidget {
  const DetailHistory({super.key});

  @override
  _DetailHistoryState createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  late final RefreshController _refreshController;
  late Future<GeneralCheckup> futureGeneralCheckup;
  List<String> statusList = [
    'Booking',
    'Approve',
    'Diproses',
    'Estimasi',
    'PKB',
    'PKB TUTUP',
    'Selesai Dikerjakan',
    'Invoice',
    'Lunas',
    'Ditolak'
  ];
  List<String> completedStatuses = [];
  String currentStatus = '';
  late String id;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
    futureGeneralCheckup = API.GCMekanikID(kategoriKendaraanId: '1');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadStatus();
    });
  }

  void loadStatus() async {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    id = arguments['id'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedStatuses = prefs.getStringList('completed_statuses_$id');
    if (savedStatuses != null && savedStatuses.isNotEmpty) {
      setState(() {
        completedStatuses = savedStatuses;
        currentStatus = completedStatuses.last;
      });
    } else {
      setState(() {
        currentStatus = statusList.first;
      });
    }
    checkAndUpdateStatus(arguments);
  }

  void checkAndUpdateStatus(Map<String, dynamic> arguments) async {
    final String newStatus = arguments['nama_status'];
    if (!completedStatuses.contains(newStatus)) {
      updateStatus(newStatus);
    }
  }

  void updateStatus(String newStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!completedStatuses.contains(newStatus)) {
      completedStatuses.add(newStatus);
      await prefs.setStringList('completed_statuses_$id', completedStatuses);
    }
    setState(() {
      currentStatus = newStatus;
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Booking':
        return MyColors.appPrimaryColor;
      case 'Approve':
        return MyColors.appPrimaryColor;
      case 'Diproses':
        return MyColors.appPrimaryColor;
      case 'Estimasi':
        return MyColors.appPrimaryColor;
      case 'PKB':
        return MyColors.appPrimaryColor;
      case 'PKB TUTUP':
        return MyColors.appPrimaryColor;
      case 'Selesai Dikerjakan':
        return MyColors.appPrimaryColor;
      case 'Invoice':
        return Colors.green;
      case 'Lunas':
        return Colors.blue;
      case 'Ditolak':
        return MyColors.redEmergencyMenu;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String status = arguments['nama_status'];
    final String alamat = arguments['alamat'];
    final String restarea = arguments['nama_cabang'];
    final String nopol = arguments['no_polisi'];
    id = arguments['id'];
    final String namajenissvc = arguments['nama_jenissvc'];
    final List<dynamic> jasa = arguments['jasa'];
    final List<dynamic> part = arguments['part'];
    Map<String, String> cabangImageAssets = {
      'Bengkelly Rest Area KM 379A': 'assets/logo/379a.jpg',
      'Bengkelly Rest Area KM 228A': 'assets/logo/228a.jpg',
      'Bengkelly Rest Area KM 389B': 'assets/logo/389b.jpg',
      'Bengkelly Rest Area KM 575B': 'assets/logo/575b.jpg',
      'Bengkelly Rest Area KM 319B': 'assets/logo/319b.jpg',
    };
    Color statusColor = getStatusColor(status ?? '');
    String imageAsset = cabangImageAssets[arguments['nama_cabang']] ?? 'assets/logo/logo_vale.png';

    double screenWidth = MediaQuery.of(context).size.width;
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
          style: GoogleFonts.nunito(color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: const WaterDropHeader(),
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${namajenissvc} ',
                              style: GoogleFonts.nunito(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor),
                            ),

                            SizedBox(height: 10),
                            Text('Status Proses',
                                style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: statusList.map((status) {
                                  bool isCompleted =
                                  completedStatuses.contains(status);
                                  return Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: isCompleted
                                              ? getStatusColor(status)
                                              : Colors.grey[200],
                                        ),
                                        child: Text(
                                          status,
                                          style: TextStyle(
                                            color: isCompleted
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.check_circle_rounded,
                                        color: isCompleted
                                            ? getStatusColor(status)
                                            : Colors.grey[300],
                                      )
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Service Proses',
                                  style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                                Row(children: [
                                  Text('No Polisi : ',
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.bold)),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child:
                                Text(
                                  '${nopol}',
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.normal, color: Colors.white),
                                ),
                              ),
                                ],)
                            ],
                          ),
                          SizedBox(height: 10),
                          WidgetTimelinetitle(
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
                            jasa: jasa, // Passing jasa to WidgetTimeline
                          ),
                          WidgetTimeline(
                            icon: Icons.settings,
                            bgcolor: MyColors.grey,
                            title1: "Detail Part",
                            title2: "Sparepart yang diganti",
                            time: "",
                            showCard2: true,
                            part: part, // Passing part to WidgetTimeline
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                if (namajenissvc == 'General Check UP/P2H')
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child:
                    Text('Status Proses P2H',
                        style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),),
                if (namajenissvc == 'General Check UP/P2H')
                  FutureBuilder<GeneralCheckup>(
                    future: futureGeneralCheckup,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child:
                            Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.data == null) {
                        return Center(
                            child: Text('No data available'));
                      }
                      final data = snapshot.data!.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return Container(
                            child: ExpansionTile(
                              title: Text(item.subHeading ??
                                  'No subheading'),
                              children:
                              item.gcus?.map((gcu) {
                                return ListTile(
                                  title: Text(gcu.gcu ?? 'No GCU'),
                                );
                              }).toList() ??
                                  [],
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onLoading() {
    _refreshController.loadComplete(); // after data returned,set the //footer state to idle
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
      _refreshController.refreshCompleted();
    });
  }
}
