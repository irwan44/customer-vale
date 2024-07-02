import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:customer_bengkelly/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../data/data_endpoint/customkendaraan.dart';
import '../../../data/data_endpoint/jenisservice.dart';
import '../../../data/data_endpoint/lokasi.dart';
import '../../../data/endpoint.dart';
import '../../authorization/componen/fade_animationtest.dart';
import '../componen/list_kendataan.dart';
import '../componen/select_caleder.dart';
import '../componen/select_maps.dart';
import '../controllers/emergencybooking_controller.dart';

class EmergencyBookingView extends StatefulWidget {
  @override
  EmergencyBookingViewState createState() => EmergencyBookingViewState();
}

class EmergencyBookingViewState extends State<EmergencyBookingView> {
  EmergencyBookingViewController controller = Get.put(EmergencyBookingViewController());
  Position? _currentPosition;
  String _currentAddress = 'Mengambil lokasi...';
  TextEditingController locationController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Current position: $_currentPosition');
      _getAddressFromLatLng();
      setState(() {
        locationController.text = '${_currentPosition!.latitude},${_currentPosition!.longitude}';
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }
  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    print('Permission status: $status');
    if (status.isGranted) {
      print('Permission already granted');
      await _getCurrentLocation();
    } else {
      var requestedStatus = await Permission.location.request();
      print('Requested permission status: $requestedStatus');
      if (requestedStatus.isGranted) {
        print('Permission granted');
        await _getCurrentLocation();
      } else {
        print('Permission denied');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permission denied'),
        ));
      }
    }
  }
  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude,_currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.subAdministrativeArea}";
      });
    } catch (e) {
      print('Error getting address: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    List<String> tipeList = ["AT", "MT"];
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Obx(() => SizedBox(
                height: 50, // <-- Your height
                child: ElevatedButton(
                  onPressed: (controller.isFormValidpic() && !controller.isLoading.value) ||
                      (controller.isFormValid() && !controller.isLoading.value)
                      ? () {
                    controller.EmergencyServiceVale();
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (controller.isFormValidpic() || controller.isFormValid())
                        ? MyColors.appPrimaryColor
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4.0,
                  ),
                  child: controller.isLoading.value
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Loading...',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
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
              )),
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
                          child: Text('Kendaraan', style: GoogleFonts.nunito(),),
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
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FractionallySizedBox(
                                      heightFactor: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 50,),
                                          Container(
                                            height: 60,
                                            padding: EdgeInsets.all(16.0),
                                            child: Text(
                                              'Pilih Kendaraan',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.appPrimaryColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListKendaraanWidget(),
                                          ),
                                        ],
                                      ),
                                    );
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
                                      (controller.selectedTransmisiPIC.value == null && controller.selectedTransmisi.value == null)
                                          ? 'Pilih Kendaraan'
                                          : (controller.selectedTransmisiPIC.value != null)
                                          ? '${controller.selectedTransmisiPIC.value!.namaMerk} - ${controller.selectedTransmisiPIC.value!.namaTipe ?? ''}'
                                          : '${controller.selectedTransmisi.value!.merks?.namaMerk} - ${controller.selectedTransmisi.value!.tipes?.map((e) => e.namaTipe).join(", ")}',
                                      style: GoogleFonts.nunito(
                                        color: (controller.selectedTransmisiPIC.value == null && controller.selectedTransmisi.value == null)
                                            ? Colors.grey
                                            : Colors.black,
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
                          child: Text('Perusahaan', style: GoogleFonts.nunito(),),
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                final result = await Get.to(() => SelectBooking());
                                if (result != null) {
                                  // Assuming result is a Map<String, dynamic> in this example
                                  // Update selected location
                                  controller.selectedLocation.value = result['name']; // Update selected location name
                                  controller.selectedLocationID.value = result['id']; // Update selected location ID
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
                                    Expanded(
                                      child: Text(
                                        controller.selectedLocation.value ?? 'Pilih Lokasi Bengkel', // Show default text if null
                                        style: GoogleFonts.nunito(
                                          color: controller.selectedLocation.value == null ? Colors.grey : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Lokasi terdeteksi :', style: GoogleFonts.nunito(),),
                              Text(_currentAddress, style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                            ],
                          ),
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
                              height: 50, // <-- TextField expands to this height.
                              child: TextField(
                                enabled: false,
                                controller: controller.locationController,
                                maxLines: null, // Set this
                                expands: true, // and this
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(13),
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                    hintText: ''
                                ),
                              ),
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
}