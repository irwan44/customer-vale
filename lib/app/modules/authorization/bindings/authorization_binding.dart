import 'package:get/get.dart';

import '../controllers/authorization_controller.dart';

class AuthorizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthorizationController>(
      () => AuthorizationController(),
    );
  }
}
