import 'dart:convert';

import 'package:customer_bengkelly/app/data/endpoint.dart';
import 'package:get/get.dart';

import '../../../data/data_endpoint/history.dart';

class HistoryController extends GetxController {
  var isLoading = false.obs;
  var bookings = <DataHis>[].obs; // Ensure this matches your data model class

  Future<void> fetchBookings() async {
    isLoading.value = true;
    try {
      var response = await API.HistoryBookingID(); // Your API call
      if (response.status == 200) {
        List<dynamic> data = jsonDecode(response.message??''); // Decode JSON to list
        bookings.assignAll(data.map((item) => DataHis.fromJson(item)).toList());
      } else {
        print('Failed to fetch bookings with status code: ${response.message}');
      }
    } catch (e) {
      print("Failed to fetch bookings: $e");
    } finally {
      isLoading.value = false;
    }
  }
  final count = 0.obs;


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
