import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../componen/custom_widget.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../controllers/authorization_controller.dart';
import '../router/router.dart';
import 'common.dart';
import 'fade_animationtest.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final AuthorizationController controller = Get.put(AuthorizationController());
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "OTP Verification",
                        style: Common().titelTheme,
                      ),
                    ),
                    FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "Masukkan kode verifikasi yang baru saja kami kirimkan ke alamat email Anda.",
                        style: Common().mediumThemeblack,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  child: Column(
                    children: [
                      FadeInAnimation(
                        delay: 1.9,
                        child: Pinput(
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          validator: (s) {
                            return s == '2222' ? null : 'Pin is incorrect';
                          },
                          pinputAutovalidateMode:
                          PinputAutovalidateMode.onSubmit,
                          controller: controller.OTPController,
                          showCursor: true,
                          onCompleted: (pin) async {
                            if (controller.OTPController.text.isNotEmpty ) {
                              try {
                                String? token = (await API.OTPID(
                                  otp: controller.OTPController.text,
                                )) as String?;

                                if (token != null) {
                                } else {
                                  Get.snackbar('Gagal OTP', 'Kode OTP Anda salah atau sudah kadaluarsa',
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white
                                  );
                                }
                              } catch (e) {
                                print('Error during login: $e');
                                Get.offAllNamed(Routes.NEWPASSWORD);
                              }
                            } else {
                              Get.snackbar('Gagal OTP', 'Kode OTP Anda salah atau sudah kadaluarsa',
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeInAnimation(
                        delay: 2.1,
                        child: CustomElevatedButton(
                          message: "Verify OTP",
                          function: () async {
                            if (controller.OTPController.text.isNotEmpty ) {
                              try {
                                String? token = (await API.OTPID(
                                  otp: controller.OTPController.text,
                                )) as String?;

                                if (token != null) {
                                } else {
                                }
                              } catch (e) {
                                print('Error during login: $e');
                              }
                            } else {
                              Get.snackbar('Gagal OTP', 'Kode OTP Anda salah atau sudah kadaluarsa',
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white
                              );
                            }
                          },
                          color: MyColors.appPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              FadeInAnimation(
                delay: 2.4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun?",
                        style: Common().hinttext,
                      ),
                      TextButton(
                          onPressed: () {
                          Get.toNamed(Routes.SINGUP);
                          },
                          child: Text(
                            "Register Sekarang",
                            style: Common().mediumTheme,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}