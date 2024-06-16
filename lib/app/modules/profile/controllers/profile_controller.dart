import 'dart:io';
import 'package:customer_bengkelly/app/data/data_endpoint/createkendaraan.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import '../../../data/data_endpoint/merekkendaraan.dart';
import '../../../data/data_endpoint/tipekendaraan.dart';
import '../../../data/endpoint.dart';
import '../../../data/publik.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  final dio.Dio _dio = dio.Dio();
  var futureMerek = Future<MerekKendaraan>.value(MerekKendaraan(data: [])).obs;
  var futureTipeKendaraan = Future<TipeKendaraan>.value(TipeKendaraan(data: [])).obs;
  var selectedMerek = ''.obs;
  var selectedTipe = ''.obs;
  var selectedMerekId = 0.obs;
  var selectedTipeID = 0.obs;
  var selectedTransmisi = ''.obs;
  var selectedKategory = ''.obs;
  String? imageUrl; // Tambahkan properti untuk URL gambar

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nopolController = TextEditingController();
  final hpController = TextEditingController();
  final warnaController = TextEditingController();
  final tahunController = TextEditingController();

  final _packageName = ''.obs;
  String get packageName => _packageName.value;
  final InAppUpdate inAppUpdate = InAppUpdate();

  get updateAvailable => null;

  Future<void> checkForUpdate() async {
    final packageInfo = (GetPlatform.isAndroid)
        ? await PackageInfo.fromPlatform()
        : PackageInfo(
      appName: '',
      packageName: '',
      version: '',
      buildNumber: '',
    );
    final currentVersion = packageInfo.version;

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.flexibleUpdateAllowed) {
        final latestVersion = updateInfo.availableVersionCode.toString();
        if (currentVersion != latestVersion) {
          showUpdateDialog();
        }
      }
    } catch (e) {
      print('Error checking for updates: $e');
    }
  }
  late final DeviceInfoPlugin deviceInfo;
  @override
  void onInit()async{
    super.onInit();
    loadMerek();
    deviceInfo = DeviceInfoPlugin();
    final androidInfo = (GetPlatform.isAndroid)
        ? await deviceInfo.androidInfo
        : AndroidDeviceInfo;
    final packageInfo = (GetPlatform.isAndroid)
        ? await PackageInfo.fromPlatform()
        : PackageInfo(
      appName: '',
      packageName: '',
      version: '',
      buildNumber: '',
    );
    _packageName.value = packageInfo.version;
  }


  void loadMerek() {
    futureMerek.value = API.merekid();
  }

  Future<void> CreateKendaraan() async {
    if (nopolController.text.isNotEmpty &&
        selectedMerek.value.isNotEmpty &&
        selectedKategory.value.isNotEmpty &&
        selectedTransmisi.value.isNotEmpty &&
        tahunController.text.isNotEmpty) {
      print('nopolisi: ${nopolController.text}');
      print('idmerk: ${selectedMerekId.value}');
      print('idtipe: ${selectedTipeID.value}');
      print('warna: ${warnaController.text}');
      print('tahun: ${tahunController.text}');
      print('categoryname: ${selectedKategory.value}');
      print('transmission: ${selectedTransmisi.value}');
      try {
        final registerResponse = await API.CreateKendaraanID(
          nopolisi: nopolController.text,
          idmerk: selectedMerekId.value.toString(),
          idtipe: selectedTipeID.value.toString(),
          warna: warnaController.text,
          tahun: tahunController.text,
          categoryname: selectedKategory.value,
          transmission: selectedTransmisi.value,
        );

        print('registerResponse: ${registerResponse.toJson()}');

        if (registerResponse != null && registerResponse.status == true) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar('Error', 'Terjadi kesalahan saat registrasi',
              backgroundColor: Colors.redAccent,
              colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar(
          'Berhasil',
          'Data kendaraan anda sudah dapat melakukan Booking service',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.HOME);
      }
    } else {
      Get.snackbar('Gagal Registrasi', 'Semua bidang harus diisi',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update(); // Update UI
    }
  }

  Future<void> updateProfile(String name, String email, String hp, String alamat) async {
    String url = 'https://mobile.techthinkhub.id/api/customer-update-profile';
    final token = Publics.controller.getToken.value ?? '';

    dio.FormData formData = dio.FormData.fromMap({
      'nama': name,
      'email': email,
      'hp': hp,
      'alamat': alamat,
      if (selectedImage != null)
        'gambar': await dio.MultipartFile.fromFile(selectedImage!.path, filename: 'profile.jpg'),
    });

    try {
      dio.Response response = await _dio.post(
        url,
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Profile updated successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Failed to update profile',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void showUpdateDialog() {}
}
