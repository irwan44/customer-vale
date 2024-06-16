import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../componen/color.dart';
import '../../../routes/app_pages.dart';
import '../../booking/componen/list_kendataan.dart';
import '../../booking/controllers/booking_controller.dart';

class PilihKendaraan extends StatefulWidget {
  const PilihKendaraan({super.key});

  @override
  State<PilihKendaraan> createState() => _PilihKendaraanState();
}

class _PilihKendaraanState extends State<PilihKendaraan> {
  final BookingController controller = Get.find<BookingController>();
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Container(
          width: double.infinity,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(Routes.TAMBAHKENDARAAN),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.appPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Tambah Kendaraan',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Text(
          'Pilih Kendaraan',
          style: GoogleFonts.nunito(
            color: MyColors.appPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Obx(
        //       () => Text(
        //     'Pilih Kendaraan: ${controller.selectedTransmisi.value?.merks?.namaMerk ?? ''}',
        //     style: GoogleFonts.nunito(
        //       color: MyColors.appPrimaryColor,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        centerTitle: false,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const WaterDropHeader(),
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListKendaraanWidget(),
        ),
      ),
    );
  }

  void _onLoading() {
    _refreshController.loadComplete();
  }

  void _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
      _refreshController.refreshCompleted();
    });
  }
}
