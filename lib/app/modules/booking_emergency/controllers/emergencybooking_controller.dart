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
import '../../../data/data_endpoint/kendaraandepartemen.dart';
import '../../../data/data_endpoint/kendaraanpic.dart';
import '../../../data/data_endpoint/lokasi.dart' as LokasiEndpoint;
import '../../../data/data_endpoint/lokasi.dart';
import '../../../data/data_endpoint/jenisservice.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../componen/berhasil_booking.dart';

class EmergencyBookingViewController extends GetxController {
  var Keluhan = ''.obs;


  var selectedService = Rx<JenisServices?>(null);
  var selectedLocation = Rx<String?>(null);
  var selectedLocationID = Rx<DataLokasi?>(null);
  var selectedDate = Rx<DateTime?>(null);
  var selectedTime = Rx<TimeOfDay?>(null);

  var tipeListPIC = <Kendaraanpic>[].obs;
  var filteredListPIC = <Kendaraanpic>[].obs;
  var selectedTransmisiPIC = Rx<Kendaraanpic?>(null);

  var tipeList = <DataKendaraan>[].obs;
  var filteredList = <DataKendaraan>[].obs;
  var selectedTransmisi = Rx<DataKendaraan?>(null);

  var tipeListDepartemen = <KendaraanDepartemen>[].obs;
  var filteredListDepartemen = <KendaraanDepartemen>[].obs;
  var selectedTransmisiDepartemen = Rx<KendaraanDepartemen?>(null);

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
    return
      selectedTransmisi.value != null &&
        selectedLocation.value != null &&
            _currentPosition != null &&
        Keluhan.value.isNotEmpty;
  }
  bool isFormValidpic() {
    return
      selectedTransmisiPIC.value != null &&
          selectedLocation.value != null &&
          _currentPosition != null &&
          Keluhan.value.isNotEmpty;
  }
  bool isFormValidDepartemen() {
    return
      selectedTransmisiDepartemen.value != null &&
          selectedLocation.value != null &&
          _currentPosition != null &&
          Keluhan.value.isNotEmpty;
  }
  Future<void> fetchAndSetDefaultLocation() async {
    var lokasi = await API.LokasiBengkellyID();
    if (lokasi.data != null && lokasi.data!.isNotEmpty) {
      var firstLocation = lokasi.data!.first;
      selectedLocationID.value = firstLocation; // Set default location
      selectedLocation.value = '${firstLocation.name}';
    }
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

  bool isFormValidEmergency() {
    return selectedTransmisi.value != null &&
        selectedLocation.value != null &&
        Keluhan.value.isNotEmpty;
  }
  bool isFormValidEmergencypic() {
    return selectedTransmisiPIC.value != null &&
        selectedLocation.value != null &&
        Keluhan.value.isNotEmpty;
  }
  bool isFormValidEmergencyDepartemen() {
    return selectedTransmisiDepartemen.value != null &&
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
        } else {
        }
        Get.snackbar('Gagal Booking', 'Terjadi kesalahan saat Booking',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      } catch (e) {
        isLoading.value = false; // Stop loading
        print('Error during registration: $e');
        Get.snackbar('Gagal Booking', 'Terjadi kesalahan saat Booking',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } else {
      Get.snackbar('Gagal Booking', 'Semua bidang harus diisi',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  Future<void> EmergencyServiceVale() async {
    if (isFormValidEmergencyDepartemen()) {
      await _handleEmergencyService(
        idKendaraan: selectedTransmisiDepartemen.value!.id.toString(),
        isPIC: true,
      );
    }

    if (isFormValidEmergencypic()) {
      await _handleEmergencyService(
        idKendaraan: selectedTransmisiPIC.value!.id.toString(),
        isPIC: true,
      );
    }

    if (isFormValidEmergency()) {
      await _handleEmergencyService(
        idKendaraan: selectedTransmisi.value!.id.toString(),
        isPIC: false,
      );
    }
  }

  Future<void> _handleEmergencyService({String? idKendaraan, required bool isPIC}) async {
    if (Keluhan.value == null || idKendaraan == null) {
      Get.snackbar('Gagal Emergency Service', 'Informasi lokasi tidak lengkap',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final idcabang = selectedLocationID.value?.geometry?.location?.id?.toString();

      if (idcabang == null) {
        Get.snackbar('Gagal Emergency Service', 'ID lokasi tidak tersedia',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        return;
      }

      // Print data to be sent to API
      print('Data to be sent to API:');
      print('ID Cabang: $idcabang');
      print('Keluhan: ${Keluhan.value}');
      print('ID Kendaraan: $idKendaraan');
      print('Location: ${locationController.text ?? ''}');

      final registerResponse = await API.EmergencyServiceValeID(
        idcabang: idcabang,
        keluhan: Keluhan.value,
        idkendaraan: idKendaraan,
        location: locationController.text ?? '',
      );

      print('API Response: $registerResponse');

      if (registerResponse != null && registerResponse.status == true) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar('Error', 'Terjadi kesalahan saat Emergency Service',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } on DioError catch (e) {
      _handleDioError(e);
    } catch (e) {
      print('Error during emergency Service: $e');
      Get.snackbar('Gagal emergency Service', 'Kendaraan anda sudah Terdaftar Sebelumnya',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }


  void _handleDioError(DioError e) {
    if (e.response != null) {
      print('Error Response data: ${e.response!.data}');
      print('Error sending request: ${e.message}');
    } else {
      print('Error sending request: ${e.message}');
    }
    Get.snackbar('Gagal emergency Service', 'Kendaraan anda sudah Terdaftar Sebelumnya',
        backgroundColor: Colors.redAccent, colorText: Colors.white);
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
    try {
      var customerKendaraan = await API.PilihKendaraan();
      var KendaraanPIC = await API.PilihKendaraanPIC();
      var KendaraanDepartemen = await API.PilihKendaraanDepartemen();
      //Depertemen
      if (KendaraanDepartemen != null) {
        tipeListDepartemen.value = (KendaraanDepartemen.dataDepartemen?.kendaraan ?? []);
        filteredListDepartemen.value = tipeListDepartemen.value;

        if (tipeListDepartemen.isNotEmpty) {
          selectedTransmisiDepartemen.value = tipeListDepartemen.first;
        }
      } else {
        tipeListDepartemen.value = [];
        filteredListDepartemen.value = [];
        selectedTransmisiDepartemen.value = null;
      }
      //PIC
      if (KendaraanPIC != null) {
        tipeListPIC.value = (KendaraanPIC.dataPic?.kendaraan ?? []).cast<Kendaraanpic>();
        filteredListPIC.value = tipeListPIC.value;

        if (tipeListPIC.isNotEmpty) {
          selectedTransmisiPIC.value = tipeListPIC.first;
        }
      } else {
        tipeListPIC.value = [];
        filteredListPIC.value = [];
        selectedTransmisiPIC.value = null;
      }
//Pelanggan
      if (customerKendaraan != null) {
        tipeList.value = customerKendaraan.datakendaraan ?? [];
        filteredList.value = tipeList.value;

        if (tipeList.isNotEmpty) {
          selectedTransmisi.value = tipeList.first;
        }
      } else {
        tipeList.value = [];
        filteredList.value = [];
        selectedTransmisi.value = null;
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTipeList();
    fetchServiceList();
    checkPermissions();
    checkPermissions1();
    fetchAndSetDefaultLocation();
    _checkPermissions();
  }
  Position? _currentPosition;
  var _currentAddress = 'Mengambil lokasi...'.obs;
  TextEditingController locationController = TextEditingController();


  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Current position: $_currentPosition');
      _getAddressFromLatLng();
      locationController.text = '${_currentPosition!.latitude},${_currentPosition!.longitude}';
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
        Get.snackbar('Error', 'Permission denied', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];
      _currentAddress.value = "${place.locality}, ${place.subAdministrativeArea}";
    } catch (e) {
      print('Error getting address: $e');
    }
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