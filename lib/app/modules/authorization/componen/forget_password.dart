import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../componen/color.dart';
import '../../../componen/custom_widget.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../controllers/authorization_controller.dart';
import 'common.dart';
import 'fade_animationtest.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final AuthorizationController controller = Get.put(AuthorizationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInAnimation(
                delay: 1.3,
                child: Text(
                  "Tidak ingat kata sandi?",
                  style: Common().titelTheme,
                ),
              ),
              const SizedBox(height: 10),
              FadeInAnimation(
                delay: 1.6,
                child: Text(
                  "Jangan khawatir! Ini terjadi. Silakan masukkan alamat email yang tertaut dengan akun Anda.",
                  style: Common().mediumThemeblack,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    FadeInAnimation(
                      delay: 1.9,
                      child: CustomTextFormField(
                        hinttext: 'Masukkan email Anda',
                        obsecuretext: false,
                        controller: controller.LupaPasswordController,
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInAnimation(
                      delay: 2.1,
                      child: CustomElevatedButton(
                        message: "Kirim Kode",
                        function: () async {
                          if (controller.LupaPasswordController.text.isNotEmpty) {
                            try {
                              String? token = (await API.LupaPasswordID(
                                email: controller.LupaPasswordController.text,
                              )) as String?;

                              if (token != null) {
                                Get.offAllNamed(Routes.OTP);
                              } else {
                                Get.snackbar(
                                  'Gagal',
                                  'Mungkin alamat email anda tidak terdaftar',
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                              }
                            } catch (e) {
                              print('Error during login: $e');
                            }
                          } else {
                            Get.snackbar(
                              'Gagal',
                              'Alamat email tidak boleh kosong',
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                          }
                        },
                        color: MyColors.appPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
