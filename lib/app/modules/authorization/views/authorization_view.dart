import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../componen/color.dart';
import '../../../componen/custom_widget.dart';
import '../../../routes/app_pages.dart';
import '../componen/fade_animationtest.dart';
import '../controllers/authorization_controller.dart';

class AuthorizationView extends GetView<AuthorizationController> {
  const AuthorizationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        toolbarHeight: 0,
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 700,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white
                        .withOpacity(0.0),
                    Colors.white
                        .withOpacity(0.9),
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset('assets/icons/logo_valeindo.svg',
                    height: 90,
                  ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: FadeInAnimation(
                    delay: 2.8,
                    child: CustomElevatedButton(
                      message: "Masuk",
                      function: () async {
                        HapticFeedback.lightImpact();
                        Get.toNamed(Routes.SINGIN);
                      },
                      color: MyColors.appPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                // Container(
                //   margin: EdgeInsets.only(left: 40, right: 40),
                //   child: FadeInAnimation(
                //     delay: 3.0,
                //     child: CustomElevatedButton2(
                //       message: "Register",
                //       function: () async {
                //         HapticFeedback.lightImpact();
                //         Get.toNamed(Routes.SINGUP);
                //       },
                //       color: Colors.white,
                //     ),
                //    ),
                //  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
