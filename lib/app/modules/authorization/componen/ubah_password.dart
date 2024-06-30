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

class UbahPasswordPage extends StatefulWidget {
  const UbahPasswordPage({Key? key}) : super(key: key);

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final AuthorizationController controller = Get.put(AuthorizationController());
  bool obscureText = true;
  bool obscureText2 = true;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void togglePasswordVisibility2() {
    setState(() {
      obscureText2 = !obscureText2;
    });
  }

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
                  "Ubah kata sandi anda",
                  style: Common().titelTheme,
                ),
              ),
              const SizedBox(height: 10),
              FadeInAnimation(
                delay: 1.6,
                child: Text(
                  "Kata sandi baru Anda harus unik dari yang digunakan sebelumnya.",
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
                        hinttext: 'Kata sandi anda saat ini',
                        obsecuretext: false,
                        controller: controller.UbahLamaPasswordController,
                      ),
                    ),
                    const SizedBox(height: 15),
                    FadeInAnimation(
                      delay: 2.2,
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.bgformborder),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: controller.UbahBaruPasswordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(18),
                            hintText: "Password Baru",
                            hintStyle: Common().hinttext,
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
                    const SizedBox(height: 15),
                    FadeInAnimation(
                      delay: 2.2,
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.bgformborder),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: controller.UbahConfirmBaruPasswordController,
                          obscureText: obscureText2,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(18),
                            hintText: "Confirm Password Baru",
                            hintStyle: Common().hinttext,
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: togglePasswordVisibility2,
                              icon: Icon(
                                obscureText2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInAnimation(
                      delay: 2.4,
                      child: CustomElevatedButton(
                        message: "Ubah Password",
                        function: () async {
                          if (controller.UbahLamaPasswordController.text.isNotEmpty &&
                              controller.UbahBaruPasswordController.text.isNotEmpty &&
                              controller.UbahConfirmBaruPasswordController.text.isNotEmpty) {
                            try {
                              String? token = await API.UbahPasswordID(
                                currentpassword: controller.UbahLamaPasswordController.text,
                                newpassword: controller.UbahBaruPasswordController.text,
                                confirmpasswordnew: controller.UbahConfirmBaruPasswordController.text,
                              ) as String?;

                              if (token != null) {
                                Get.offAllNamed(Routes.SINGIN);
                              } else {
                              }
                            } catch (e) {
                              print('Error during password reset: $e');
                            }
                          } else {
                            Get.snackbar(
                              'Gagal Ubah Password',
                              'Password Anda sama dengan password lama',
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
