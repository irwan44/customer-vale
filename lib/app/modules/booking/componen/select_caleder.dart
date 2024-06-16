import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/booking_controller.dart';

class CalendarTimePickerPage extends StatelessWidget {
  final BookingController controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (!controller.isDateSelected.value) {
            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: controller.focusedDay.value,
                  calendarFormat: controller.calendarFormat.value,
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.selectedDate.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.onDaySelected(selectedDay, focusedDay);
                  },
                  onFormatChanged: (format) {
                    if (controller.calendarFormat.value != format) {
                      controller.onFormatChanged(format);
                    }
                  },
                  onPageChanged: (focusedDay) {
                    controller.onPageChanged(focusedDay);
                  },
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: controller.selectDate,
                    child: Text('Pilih Jadwal'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: MyColors.appPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(controller.selectedDate.value!),
                    style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 200,
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    onTimerDurationChanged: (duration) {
                      controller.selectTime(duration);
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () => controller.confirmSelection(context),
                    child: Text('Pilih Jam'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: MyColors.appPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ],
    );
  }
}
