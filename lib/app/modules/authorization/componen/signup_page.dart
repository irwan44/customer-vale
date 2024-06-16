import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../componen/color.dart';
import '../../../componen/custom_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/authorization_controller.dart';
import 'common.dart';
import 'fade_animationtest.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscureText = true;
  bool obscureText2 = true;
  final controller = Get.find<AuthorizationController>();

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInAnimation(
                        delay: 0.9,
                        child: Text(
                          "Halo! Daftar untuk Memulai",
                          style: Common().titelTheme,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    child: Column(
                      children: [
                        FadeInAnimation(
                          delay: 1.5,
                          child: CustomTextFormField(
                            hinttext: 'Username',
                            obsecuretext: false,
                            controller: controller.usernameController,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: CustomTextFormField(
                            hinttext: 'Email',
                            obsecuretext: false,
                            controller: controller.emailController,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.2,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: controller.passwordController,
                              obscureText: obscureText,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18),
                                hintText: "Password",
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
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.2,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: controller.confirmPasswordController,
                              obscureText: obscureText2,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18),
                                hintText: "Confirm Password",
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
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInAnimation(
                          delay: 2.7,
                          child: Obx(() => CustomElevatedButton(
                            message: "Next",
                            function: controller.isSignupFormValid.value
                                ? () async {
                              Get.toNamed(Routes.SINGUPNEXT);
                            }
                                : () async {},
                            color: controller.isSignupFormValid.value
                                ? MyColors.appPrimaryColor
                                : Colors.grey,
                          )),
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
                        FadeInAnimation(
                          delay: 3.2,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 30, left: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Icons can be added here
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeInAnimation(
                  delay: 3.6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah punya Akun ?",
                          style: Common().hinttext,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(const LoginPage());
                            },
                            child: Text(
                              "Login Sekarang",
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
    );
  }
}
