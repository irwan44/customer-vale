import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:customer_bengkelly/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import package intl
import '../../../componen/custom_widget.dart';
import '../../../data/data_endpoint/bookingcustomer.dart';
import '../../../data/data_endpoint/customkendaraan.dart';
import '../../../data/data_endpoint/jenisservice.dart';
import '../../authorization/componen/common.dart';
import '../../authorization/componen/fade_animationtest.dart';
import '../../authorization/componen/login_page.dart';
import '../componen/list_kendataan.dart';
import '../componen/select_caleder.dart';
import '../componen/select_maps.dart';
import '../componen/select_maps_emergency.dart';
import '../controllers/booking_controller.dart';


class EmergencyBooking extends StatefulWidget {
  const EmergencyBooking({super.key});

  @override
  State<EmergencyBooking> createState() => _EmergencyBookingState();
}

class _EmergencyBookingState extends State<EmergencyBooking> {

  final controller = Get.find<BookingController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectBookingEmergency(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> tipeList = ["AT", "MT"];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Emergency Service', style: GoogleFonts.nunito(color: Colors.red, fontWeight: FontWeight.bold, ),),
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Anda telah memilih lokasi Bengkelly di'),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                // border: Border.all(color: MyColors.bgformborder),
                                borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                              onTap: () async {
                                final result = await Get.to(() => SelectBooking());
                                if (result != null) {
                                  controller.selectedLocation.value = result;
                                }
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
                                      controller.selectedLocation.value == null
                                          ? 'Pilih Lokasi Bengkel'
                                          : '${controller.selectedLocation.value}',
                                      style: GoogleFonts.nunito(
                                        color: controller.selectedLocation.value == null ? Colors.grey : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsetsDirectional.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: 
                                    Text('Ubah', style: GoogleFonts.nunito(color: Colors.white,fontWeight: FontWeight.bold),),)
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text('Jenis Kendaraaan'),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.bgformborder),
                                borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ListKendaraanWidget();
                                  },
                                );
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
                                      controller.selectedTransmisi.value == null
                                          ? 'Jenis Kendaraan'
                                          : '${controller.selectedTransmisi.value!.merks?.namaMerk} - ${controller.selectedTransmisi.value!.tipes?.map((e) => e.namaTipe).join(", ")}',
                                      style: GoogleFonts.nunito(
                                        color: controller.selectedTransmisi.value == null ? Colors.grey : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text('Keluhan (Opsional)'),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder), // Change to your primary color
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              height: 200, // <-- TextField expands to this height.
                              child: TextField(
                                controller: TextEditingController(text: controller.Keluhan.value),
                                onChanged: (value) {
                                  controller.Keluhan.value = value;
                                },
                                maxLines: null, // Set this
                                expands: true, // and this
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(18),
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                    hintText: 'Keluhan'
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        ElevatedButton(
                          onPressed: () => controller.EmergencyService(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
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
                                'Emergency Service',
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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
    );
  }

  void _showBottomSheetService(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.serviceList.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Pilih Jenis Service',
                    style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.serviceList.length,
                    itemBuilder: (BuildContext context, int index) {
                      JenisServices item = controller.serviceList[index];
                      bool isSelected = item == controller.selectedService.value;
                      return ListTile(
                        title: Text(
                          item.namaJenissvc ?? 'Unknown',
                          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          controller.selectService(item);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        });
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.tipeList.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Pilih Kendaraan',
                    style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.tipeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      DataKendaraan item = controller.tipeList[index];
                      bool isSelected = item == controller.selectedTransmisi.value;
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              '${item.merks?.namaMerk}',
                              style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' - ',
                              style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                            ),
                            ...?item.tipes?.map((tipe) => Text(
                              '${tipe.namaTipe}',
                              style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                            )).toList(),
                          ],
                        ),
                        subtitle: Text(
                            'No Polisi: ${item.noPolisi}\nWarna: ${item.warna} - Tahun: ${item.tahun}'
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          controller.selectTransmisi(item);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        });
      },
    );
  }
}