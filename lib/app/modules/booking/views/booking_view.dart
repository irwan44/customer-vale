import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:customer_bengkelly/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../data/data_endpoint/customkendaraan.dart';
import '../../../data/data_endpoint/jenisservice.dart';
import '../../authorization/componen/fade_animationtest.dart';
import '../componen/list_kendataan.dart';
import '../componen/select_caleder.dart';
import '../componen/select_maps.dart';
import '../controllers/booking_controller.dart';

class BookingView extends StatefulWidget {
  @override
  BookingViewState createState() => BookingViewState();
}

class BookingViewState extends State<BookingView> {
  final controller = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    List<String> tipeList = ["AT", "MT"];
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
              child: Obx(
                    () => SizedBox(
                  height: 50, // <-- Your height
                  child: ElevatedButton(
                    onPressed: controller.isFormValid()
                        ? () {
                      Get.toNamed(Routes.DETAILBOOKING);
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isFormValid()
                          ? MyColors.appPrimaryColor
                          : Colors.grey,
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
                          'Booking Sekarang',
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
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Booking', style: GoogleFonts.nunito(color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),),
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
           Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInAnimation(
                          delay: 1.8,
                          child: Text('Jenis Kendaraan', style: GoogleFonts.nunito(),),
                        ),
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
                        FadeInAnimation(
                          delay: 1.8,
                          child: Text('Lokasi Bengkelly', style: GoogleFonts.nunito(),),
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.bgformborder),
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
                                    const Icon(Icons.map_sharp, color: Colors.grey),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Text('Pilih Jadwal', style: GoogleFonts.nunito(),),
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.bgformborder),
                                borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                              onTap: () async {
                                final result = await showModalBottomSheet<DateTime>(
                                  context: context,
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return DraggableScrollableSheet(
                                      expand: false,
                                      builder: (BuildContext context, ScrollController scrollController) {
                                        return SingleChildScrollView(
                                          controller: scrollController,
                                          child: CalendarTimePickerPage(),
                                        );
                                      },
                                    );
                                  },
                                );
                                if (result != null) {
                                  controller.selectedDate.value = result;
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
                                      controller.selectedDate.value == null
                                          ? 'Pilih Jadwal Booking'
                                          : DateFormat('dd/MM/yyyy HH:mm').format(controller.selectedDate.value!),
                                      style: GoogleFonts.nunito(
                                        color: controller.selectedDate.value == null ? Colors.grey : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(Icons.calendar_month_rounded, color: Colors.grey),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Text('Pilih Jasa', style: GoogleFonts.nunito(),),
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.bgformborder),
                                borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                              onTap: () {
                                _showBottomSheetService(context);
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
                                          ? 'Pilih Jasa Service'
                                          : '${controller.selectedService.value!.namaJenissvc}',
                                      style: GoogleFonts.nunito(
                                        color: controller.selectedService.value == null || controller.selectedService.value!.namaJenissvc == "Default Service" ? Colors.grey : Colors.black,
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
                        FadeInAnimation(
                          delay: 1.8,
                          child: Text('Keluhan', style: GoogleFonts.nunito(),),
                        ),
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
                                    hintText: 'Keluhan Kendaraan anda'
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