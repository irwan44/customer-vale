import 'package:customer_bengkelly/app/data/data_endpoint/lupapassword.dart';
import 'package:customer_bengkelly/app/data/data_endpoint/merekkendaraan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/data_endpoint/tipekendaraan.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';

class AuthorizationController extends GetxController {
  // Controllers for SignupPage
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final LupaPasswordController = TextEditingController();
  final OTPController = TextEditingController();
  final VerikasiEmailController = TextEditingController();
  final VerikasiPassowrdBaruController = TextEditingController();
  final VerikasiPassowrdBarulagiController = TextEditingController();
  final UbahLamaPasswordController = TextEditingController();
  final UbahBaruPasswordController = TextEditingController();
  final UbahConfirmBaruPasswordController = TextEditingController();

  final nopolController = TextEditingController();
  final hpController = TextEditingController();
  final warnaController = TextEditingController();
  final tahunController = TextEditingController();
  final vinnumberController = TextEditingController();

  var isSignupFormValid = false.obs;
  var isRegisterFormValid = false.obs;

  var futureMerek = Future<MerekKendaraan>.value(MerekKendaraan(data: [])).obs;
  var futureTipeKendaraan = Future<TipeKendaraan>.value(TipeKendaraan(data: [])).obs;
  var selectedMerek = ''.obs;
  var selectedTipe = ''.obs;
  var selectedMerekId = 0.obs;
  var selectedTipeID = 0.obs;
  var selectedTransmisi = ''.obs;
  var selectedKategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    usernameController.addListener(_validateSignupForm);
    emailController.addListener(_validateSignupForm);
    passwordController.addListener(_validateSignupForm);
    confirmPasswordController.addListener(_validateSignupForm);
    nopolController.addListener(_validateRegisterForm);
    hpController.addListener(_validateRegisterForm);
    warnaController.addListener(_validateRegisterForm);
    tahunController.addListener(_validateRegisterForm);
    vinnumberController.addListener(_validateRegisterForm);
    selectedMerek.listen((_) => _validateRegisterForm());
    selectedTipe.listen((_) => _validateRegisterForm());
    selectedTransmisi.listen((_) => _validateRegisterForm());
    selectedKategory.listen((_) => _validateRegisterForm());
    loadMerek();
  }
  void loadMerek() {
    futureMerek.value = API.merekid();
  }
  void _validateSignupForm() {
    isSignupFormValid.value = usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  void _validateRegisterForm() {
    isRegisterFormValid.value = nopolController.text.isNotEmpty &&
        hpController.text.isNotEmpty &&
        warnaController.text.isNotEmpty &&
        tahunController.text.isNotEmpty &&
        vinnumberController.text.isNotEmpty &&
        selectedMerek.isNotEmpty &&
        selectedTipe.isNotEmpty &&
        selectedTransmisi.isNotEmpty &&
        selectedKategory.isNotEmpty;
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nopolController.dispose();
    hpController.dispose();
    vinnumberController.dispose();
    warnaController.dispose();
    tahunController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    if (isRegisterFormValid.value) {
      try {
        final registerResponse = await API.RegisterID(
          nama: usernameController.text,
          hp: hpController.text,
          email: emailController.text,
          password: passwordController.text,
          passwordconfirmation: confirmPasswordController.text,
          alamat: '-',
          nopolisi: nopolController.text,
          idmerk: selectedMerekId.value.toString(),
          idtipe: selectedTipeID.value.toString(),
          kategorikendaraan: selectedKategory.value,
          tahun: tahunController.text,
          warna: warnaController.text,
          vinnumber: vinnumberController.text,
          transmisi: selectedTransmisi.value,
        );

        if (registerResponse != null && registerResponse.status == true) {
          Get.offAllNamed(Routes.SINGIN);
        } else {
          Get.snackbar('Error', 'Terjadi kesalahan saat registrasi',
              backgroundColor: Colors.redAccent,
              colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar('Gagal Registrasi', 'Terjadi kesalahan saat registrasi',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    } else {
      Get.snackbar('Gagal Registrasi', 'Semua bidang harus diisi',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }
}
