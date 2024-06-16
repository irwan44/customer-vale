import 'package:get/get.dart';

import '../controllers/emergencybooking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmergencyBookingViewController>(
      () => EmergencyBookingViewController(),
    );
  }
}
