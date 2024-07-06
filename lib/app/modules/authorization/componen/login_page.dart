import 'package:customer_bengkelly/app/modules/authorization/componen/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../componen/color.dart';
import '../../../componen/custom_widget.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../controllers/authorization_controller.dart';
import 'common.dart';
import 'fade_animationtest.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  final controller = Get.find<AuthorizationController>();
  final storage = GetStorage();
  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 700,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white
                        .withOpacity(0.0),
                    Colors.white
                        .withOpacity(0.9),
                    Colors.white,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/logo_valeindo.svg',
                    height: 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              child: CustomTextFormField(
                                hinttext: 'Masukkan email Anda',
                                obsecuretext: false,
                                controller:
                                    controller.EmailController, // Tambahkan controller untuk TextFormField
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            FadeInAnimation(
                              delay: 2.2,
                              child:
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: MyColors.bgformborder),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                              TextFormField(
                                controller: controller.PasswordController,
                                obscureText: obscureText,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18),
                                  hintText: "Masukkan kata sandi Anda",
                                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: togglePasswordVisibility,
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ),
                            FadeInAnimation(
                              delay: 2.5,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                   Get.toNamed(Routes.LUPAPASSWORD);
                                  },
                                  child: Text(
                                    "Lupa Password ?",
                                    style: Common().semiboldblack,
                                  ),
                                ),
                              ),
                            ),
                            FadeInAnimation(
                              delay: 2.8,
                              child: CustomElevatedButton(
                                message: "Masuk",
                                function: () async {
                                  HapticFeedback.lightImpact();
                                  if (controller.EmailController.text.isNotEmpty &&
                                      controller.PasswordController.text.isNotEmpty) {
                                    try {
                                      String? fcmToken = storage.read('fcm_token');
                                      print("Sending API request with:");
                                      print("Email: ${controller.EmailController.text}");
                                      print("Password: ${controller.PasswordController.text}");
                                      print("FCM Token: $fcmToken");

                                      String? token = await API.login(
                                        email: controller.EmailController.text,
                                        password: controller.PasswordController.text,
                                        fcmtoken: fcmToken ?? '',
                                      );

                                      if (token != null) {
                                        Get.offAllNamed(Routes.HOME);
                                        print("Login successful, received token: $token");
                                      } else {
                                        Get.snackbar('Error', 'Terjadi kesalahan saat login',
                                            backgroundColor: Colors.redAccent,
                                            colorText: Colors.white
                                        );
                                      }
                                    } catch (e) {
                                      print('Error during login: $e');
                                      Get.snackbar('Gagal Login', 'Terjadi kesalahan saat login',
                                          backgroundColor: Colors.redAccent,
                                          colorText: Colors.white
                                      );
                                    }
                                  } else {
                                    Get.snackbar('Gagal Login', 'Username dan Password harus diisi',
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
                    const FadeInAnimation(
                      delay: 3.2,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, right: 30, left: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SvgPicture.asset(
                            //     "assets/images/facebook_ic (1).svg"),
                            // SvgPicture.asset(
                            //     "assets/images/google_ic-1.svg"),
                            // Image.asset("assets/images/Vector.png")
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    FadeInAnimation(
                      delay: 3.6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Tidak punya Akun ?",
                              style: Common().hinttext,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(const SignupPage());
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
          ),
        ),
      ),
    );
  }
}
