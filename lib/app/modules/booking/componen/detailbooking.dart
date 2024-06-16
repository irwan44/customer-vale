import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../data/data_endpoint/generalcekup.dart';
import '../../../data/endpoint.dart';
import '../../authorization/componen/fade_animationtest.dart';
import '../controllers/booking_controller.dart';

class DetailBookingView extends StatefulWidget {
  @override
  DetailBookingViewState createState() => DetailBookingViewState();
}

class DetailBookingViewState extends State<DetailBookingView> {
  final controller = Get.find<BookingController>();
  late Future<GeneralCheckup> futureGeneralCheckup;

  @override
  void initState() {
    super.initState();
    futureGeneralCheckup = API.GCMekanikID(kategoriKendaraanId: '1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: SizedBox(
                height: 50, // <-- Your height
                child: ElevatedButton(
                  onPressed: () => controller.BookingID(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 4.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        'Konfirmasi Sekarang',
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
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Detail Booking', style: GoogleFonts.nunito(color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),),
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeInAnimation(
                        delay: 1.8,
                        child: Text('Cek Kembali Data Booking Anda', style: GoogleFonts.nunito(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor, fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FadeInAnimation(
                                delay: 1.8,
                                child: Text('Detail Kendaraan', style: GoogleFonts.nunito(),),
                              ),
                              SizedBox(height: 10,),
                              FadeInAnimation(
                                delay: 1.8,
                                child: Container(
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      color: MyColors.bg,
                                      border: Border.all(color: MyColors.bgformborder),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    onTap: () {
                                    },
                                    child: Obx(() => InputDecorator(
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('${controller.selectedTransmisi.value!.merks?.namaMerk}',style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                                              Text('${controller.selectedTransmisi.value!.noPolisi}'),
                                              Row(children: [
                                                Text('${controller.selectedTransmisi.value!.warna}'),
                                                Text(' - '),
                                                Text('Tahun ${controller.selectedTransmisi.value!.tahun}'),
                                              ],)
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              FadeInAnimation(
                                delay: 1.8,
                                child: Text('Detail Lokasi, Tanggal dan Waktu', style: GoogleFonts.nunito(),),
                              ),
                              SizedBox(height: 10,),

                              FadeInAnimation(
                                delay: 1.8,
                                child: Container(
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      color: MyColors.bg,
                                      border: Border.all(color: MyColors.bgformborder),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    onTap: () async {
                                    },
                                    child: Obx(() => InputDecorator(
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${controller.selectedLocation.value!}', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                                          SizedBox(height: 10,),
                                          Text(
                                            controller.selectedDate.value == null
                                                ? 'Pilih Jadwal'
                                                : DateFormat('dd/MM/yyyy HH:mm').format(controller.selectedDate.value!),
                                            style: GoogleFonts.nunito(
                                              color: controller.selectedDate.value == null ? Colors.grey : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              FadeInAnimation(
                                delay: 1.8,
                                child: Text('Jenis Service', style: GoogleFonts.nunito(),),
                              ),
                              SizedBox(height: 10,),
                              FadeInAnimation(
                                delay: 1.8,
                                child: Container(
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      color: MyColors.bg,
                                      border: Border.all(color: MyColors.bgformborder),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    onTap: () {
                                    },
                                    child: Obx(() => InputDecorator(
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.selectedService.value == null || controller.selectedService.value!.namaJenissvc == "Default Service"
                                                ? ' '
                                                : '${controller.selectedService.value!.namaJenissvc}',
                                            style: GoogleFonts.nunito(
                                              color: controller.selectedService.value == null || controller.selectedService.value!.namaJenissvc == "Default Service" ? Colors.grey : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                          FadeInAnimation(
                            delay: 1.8,
                            child:
                              Obx(() {
                                if (controller.selectedService.value != null &&
                                    (controller.selectedService.value!.namaJenissvc == "General Check UP/P2H" ||
                                        controller.selectedService.value!.namaJenissvc == "General Check UP/P2H")) {
                                  return FutureBuilder<GeneralCheckup>(
                                    future: futureGeneralCheckup,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(child: Text('Error: ${snapshot.error}'));
                                      } else if (!snapshot.hasData || snapshot.data!.dataGeneralCheckUp == null) {
                                        return Center(child: Text('No data available'));
                                      }
                                      final data = snapshot.data!.dataGeneralCheckUp!;
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          final item = data[index];
                                          return Container(
                                            child: ExpansionTile(
                                              title: Text(item.subHeading ?? 'No subheading'),
                                              children: item.gcus?.map((gcu) {
                                                return ListTile(
                                                  title: Text(gcu.gcu ?? 'No GCU'),
                                                );
                                              }).toList() ?? [],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }),),
                              FadeInAnimation(
                                delay: 1.8,
                                child: Text('Keluhan', style: GoogleFonts.nunito(),),
                              ),
                              SizedBox(height: 10,),
                              FadeInAnimation(
                                delay: 1.8,
                                child: Container(
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                    color: MyColors.bg,
                                    border: Border.all(color: MyColors.bgformborder), // Change to your primary color
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    height: 200, // <-- TextField expands to this height.
                                    child: TextFormField(
                                      maxLines: null,
                                      expands: true,
                                      readOnly: true,
                                      style: GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.bold),
                                      controller: TextEditingController(text: controller.Keluhan.value),
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(18),
                                          border: InputBorder.none,
                                          fillColor: Colors.black,
                                          labelStyle: GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.bold),
                                          hintStyle: GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.bold),
                                          hintText: 'Keluhan'
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          height: 90,
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
