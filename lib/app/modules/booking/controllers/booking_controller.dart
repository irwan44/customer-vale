import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/data_endpoint/bookingcustomer.dart';
import '../../../data/data_endpoint/customkendaraan.dart';
import '../../../data/data_endpoint/lokasi.dart' as LokasiEndpoint;
import '../../../data/data_endpoint/lokasi.dart';
import '../../../data/data_endpoint/jenisservice.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../componen/berhasil_booking.dart';

class BookingController extends GetxController {
  var Keluhan = ''.obs;
  var selectedTransmisi = Rx<DataKendaraan?>(null);
  var selectedService = Rx<JenisServices?>(null);
  var selectedLocation = Rx<String?>(null);
  var selectedLocationID = Rx<DataLokasi?>(null);
  var selectedDate = Rx<DateTime?>(null);
  var selectedTime = Rx<TimeOfDay?>(null);
  var tipeList = <DataKendaraan>[].obs;
  var filteredList = <DataKendaraan>[].obs;
  var serviceList = <JenisServices>[].obs;
  var isLoading = true.obs;

  var calendarFormat = CalendarFormat.month.obs;
  var focusedDay = DateTime.now().obs;
  var isDateSelected = false.obs;

  late GoogleMapController mapController;
  var currentPosition = Rxn<Position>();
  var markers = <Marker>[].obs;
  var locationData = <LokasiEndpoint.DataLokasi>[].obs;
  var currentAddress = 'Mengambil lokasi...'.obs;
  final panelController = PanelController();

  bool isFormValid() {
    return selectedTransmisi.value != null &&
        selectedService.value != null &&
        selectedLocation.value != null &&
        selectedDate.value != null &&
        selectedTime.value != null &&
        Keluhan.value.isNotEmpty;
  }

  bool isFormValidEmergency() {
    return selectedTransmisi.value != null &&
        selectedLocation.value != null &&
        Keluhan.value.isNotEmpty;
  }

  void selectTransmisi(DataKendaraan value) {
    selectedTransmisi.value = value;
  }

  void selectService(JenisServices value) {
    selectedService.value = value;
  }

  void selectLocation(DataLokasi locationData) {
    selectedLocationID.value = locationData;
    final id = locationData.geometry?.location?.id ?? '';
    final name = locationData.name ?? '';
    selectedLocation.value = '$name-$id';
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDate.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
  }

  void selectDate() {
    if (selectedDate.value != null) {
      isDateSelected.value = true;
    }
  }

  void selectTime(Duration duration) {
    selectedTime.value = TimeOfDay(
      hour: duration.inHours,
      minute: duration.inMinutes % 60,
    );
  }

  void confirmSelection(BuildContext context) {
    if (selectedDate.value != null && selectedTime.value != null) {
      final selectedDateTime = DateTime(
        selectedDate.value!.year,
        selectedDate.value!.month,
        selectedDate.value!.day,
        selectedTime.value!.hour,
        selectedTime.value!.minute,
      );
      Navigator.pop(context, selectedDateTime);
    }
  }

  Future<void> BookingID() async {
    if (isFormValid()) {
      try {
        isLoading.value = true; // Start loading
        if (selectedLocationID.value == null || selectedLocationID.value!.geometry == null || selectedLocationID.value!.geometry!.location == null) {
          Get.snackbar('Gagal Booking', 'Informasi lokasi tidak lengkap',
              backgroundColor: Colors.redAccent, colorText: Colors.white);
          isLoading.value = false; // Stop loading
          return;
        }
        final idcabang = selectedLocationID.value!.geometry!.location!.id.toString();

        final DateTime selectedDateTime = DateTime(
          selectedDate.value!.year,
          selectedDate.value!.month,
          selectedDate.value!.day,
          selectedTime.value!.hour,
          selectedTime.value!.minute,
        );

        print('idcabang: $idcabang');
        print('idjenissvc: ${selectedService.value!.id}');
        print('keluhan: ${Keluhan.value}');
        print('tglbooking: ${DateFormat('dd/MM/yyyy').format(selectedDateTime)}');
        print('jambooking: ${DateFormat('HH:mm').format(selectedDateTime)}');
        print('idkendaraan: ${selectedTransmisi.value!.id}');

        // Sending the request
        final Response = await API.BookingID(
          idcabang: idcabang,
          idjenissvc: selectedService.value!.id.toString(),
          keluhan: Keluhan.value,
          tglbooking: DateFormat('dd/MM/yyyy').format(selectedDateTime).toString(),
          jambooking: DateFormat('HH:mm').format(selectedDateTime).toString(),
          idkendaraan: selectedTransmisi.value!.id.toString(),
        );

        isLoading.value = false; // Stop loading

        if (Response != null && Response.status == true) {
          Get.snackbar(
            'Berhasil',
            'Booking Service akan segera di layani',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(Routes.HOME);
        } else {
          print(Response);
          Get.snackbar('Error', 'Terjadi kesalahan saat Booking',
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      } on DioError catch (e) {
        isLoading.value = false; // Stop loading
        if (e.response != null) {
          print('Error Response data: ${e.response!.data}');
          print('Error sending request: ${e.message}');
        }
      } catch (e) {
        isLoading.value = false; // Stop loading
        print('Error during booking: $e');
        Get.snackbar('Gagal Booking', 'Terjadi kesalahan saat Booking',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } else {
      Get.snackbar('Gagal Booking', 'Semua bidang harus diisi',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  Future<void> EmergencyService() async {
    if (isFormValidEmergency()) {
      try {
        if (Keluhan.value == null || selectedTransmisi.value!.id == null) {
          Get.snackbar('Gagal Emergency Service', 'Informasi lokasi tidak lengkap',
              backgroundColor: Colors.redAccent, colorText: Colors.white);
          return;
        }
        final idcabang = selectedLocationID.value!.geometry!.location!.id.toString();

        // Logging the values to ensure they are correct
        print('idcabang: $idcabang');
        print('keluhan: ${Keluhan.value}');
        print('berita: ${'Untuk emergency Service'}');
        print('idkendaraan: ${selectedTransmisi.value!.id}');

        // Sending the request
        final registerResponse = await API.EmergencyServiceID(
          idcabang: idcabang,
          keluhan: Keluhan.value,
          berita: 'Untuk emergency Service',
          idkendaraan: selectedTransmisi.value!.id.toString(),
        );

        if (registerResponse != null && registerResponse.status == true) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar('Error', 'Terjadi kesalahan saat Emergency Service',
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      } on DioError catch (e) {
        if (e.response != null) {
          print('Error Response data: ${e.response!.data}');
          print('Error sending request: ${e.message}');
        } else {
          print('Error sending request: ${e.message}');
        }
        Get.snackbar('Gagal emergency Service', 'Terjadi kesalahan saat Emergency Service',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      } catch (e) {
        print('Error during emergency Service: $e');
        Get.snackbar('Gagal emergency Service', 'Terjadi kesalahan saat Emergency Service',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } else {
      Get.snackbar('Gagal Emergency Service', 'Semua bidang harus diisi',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  Future<void> fetchServiceList() async {
    isLoading.value = true;
    var jenisservice = await API.JenisServiceID();
    if (jenisservice != null) {
      serviceList.value = jenisservice.dataservice ?? [];
    }
    isLoading.value = false;
  }

  Future<void> fetchTipeList() async {
    isLoading.value = true;
    var customerKendaraan = await API.PilihKendaraan();
    if (customerKendaraan != null) {
      tipeList.value = customerKendaraan.datakendaraan ?? [];
      filteredList.value = tipeList;  // Ensure filteredList is initialized with tipeList
      if (tipeList.isNotEmpty) {
        selectedTransmisi.value = tipeList.first;
      }
    }
    isLoading.value = false;
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredList.value = tipeList;
    } else {
      filteredList.value = tipeList.where((item) {
        return item.noPolisi!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void resetSearch() {
    filteredList.value = tipeList;
  }

  @override
  void onInit() {
    super.onInit();
    fetchTipeList();
    fetchServiceList();
    checkPermissions();
    checkPermissions1();
  }

  Future<void> getCurrentLocation() async {
    try {
      currentPosition.value = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Current position: ${currentPosition.value}');
      getAddressFromLatLng();
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.value!.latitude, currentPosition.value!.longitude);

      Placemark place = placemarks[0];

      currentAddress.value = "${place.locality}, ${place.subAdministrativeArea}";
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  Future<void> checkPermissions() async {
    var status = await Permission.location.status;
    print('Permission status: $status');
    if (status.isGranted) {
      print('Permission already granted');
      await getCurrentLocation();
      await fetchLocations();
    } else {
      var requestedStatus = await Permission.location.request();
      print('Requested permission status: $requestedStatus');
      if (requestedStatus.isGranted) {
        print('Permission granted');
        await getCurrentLocation();
        await fetchLocations();
      } else {
        print('Permission denied');
        Get.snackbar('Permission denied', 'Location permission is required to access current location',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> getCurrentLocation2() async {
    try {
      currentPosition.value = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Current position: ${currentPosition.value}');
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> checkPermissions1() async {
    var status = await Permission.location.status;
    print('Permission status: $status');
    if (status.isGranted) {
      print('Permission already granted');
      await getCurrentLocation2();
    } else {
      var requestedStatus = await Permission.location.request();
      print('Requested permission status: $requestedStatus');
      if (requestedStatus.isGranted) {
        print('Permission granted');
        await getCurrentLocation2();
      } else {
        print('Permission denied');
        Get.snackbar('Permission denied', 'Location permission is required to access current location',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> fetchLocations() async {
    try {
      final lokasi = await API.LokasiBengkellyID();
      if (lokasi.data != null && currentPosition.value != null) {
        locationData.value = lokasi.data!;
        for (var data in lokasi.data!) {
          final location = data.geometry?.location;
          if (location != null && location.lat != null && location.lng != null) {
            print('Fetched location: lat=${location.lat}, lng=${location.lng}');
            final latLng = LatLng(double.parse(location.lat!), double.parse(location.lng!));
            final distance = calculateDistance(
              currentPosition.value!.latitude,
              currentPosition.value!.longitude,
              latLng.latitude,
              latLng.longitude,
            );
            print('Adding marker at: $latLng');
            markers.add(
              Marker(
                markerId: MarkerId(location.id.toString()),
                position: latLng,
                infoWindow: InfoWindow(
                  title: data.name,
                  snippet: 'Distance: ${distance.toStringAsFixed(2)} km',
                ),
                onTap: () {
                  selectedLocationID.value = data;
                },
              ),
            );
          }
        }
      }
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((endLatitude - startLatitude) * p) / 2 +
        cos(startLatitude * p) * cos(endLatitude * p) * (1 - cos((endLongitude - startLongitude) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
