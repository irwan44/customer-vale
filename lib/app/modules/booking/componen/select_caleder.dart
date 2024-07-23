import 'package:customer_bengkelly/app/modules/booking/controllers/booking_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../componen/color.dart';

class CalendarTimePickerPage extends StatelessWidget {
  final BookingController controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Obx(() {
            return Column(
              children: [
                if (!controller.isDateSelected.value)
                  Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.6,
                        ),
                        child: TableCalendar(
                          firstDay: DateTime.now(),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: controller.focusedDay.value,
                          calendarFormat: controller.calendarFormat.value,
                          selectedDayPredicate: (day) {
                            return isSameDay(controller.selectedDate.value, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            controller.onDaySelected(selectedDay, focusedDay);
                            controller.isDateSelected.value = true;
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
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                else
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          controller.selectedDate.value != null
                              ? DateFormat('dd/MM/yyyy').format(controller.selectedDate.value!)
                              : '',
                          style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.selectedTime.value != null
                                ? 'jam ${controller.selectedTime.value!.hour} '
                                : '',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 20),
                          Text(
                            controller.selectedTime.value != null
                                ? 'menit ${controller.selectedTime.value!.minute} '
                                : '',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Container(
                        height: 200,
                        child: Row(
                          children: [
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 32.0,
                                scrollController: FixedExtentScrollController(
                                  initialItem: controller.selectedTime.value?.hour ?? 0,
                                ),
                                onSelectedItemChanged: (index) {
                                  final newHour = index;
                                  final newMinute = controller.selectedTime.value?.minute ?? 0;
                                  final newTime = TimeOfDay(hour: newHour, minute: newMinute);
                                  // Convert TimeOfDay to Duration
                                  final duration = Duration(hours: newTime.hour, minutes: newTime.minute);
                                  controller.selectTime(duration);
                                },
                                children: List.generate(
                                  24,
                                      (index) => Center(child: Text(index.toString())),
                                ),
                              ),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 32.0,
                                scrollController: FixedExtentScrollController(
                                  initialItem: controller.selectedTime.value?.minute ?? 0,
                                ),
                                onSelectedItemChanged: (index) {
                                  final newMinute = index;
                                  final newHour = controller.selectedTime.value?.hour ?? 0;
                                  final newTime = TimeOfDay(hour: newHour, minute: newMinute);
                                  // Convert TimeOfDay to Duration
                                  final duration = Duration(hours: newTime.hour, minutes: newTime.minute);
                                  controller.selectTime(duration);
                                },
                                children: List.generate(
                                  60,
                                      (index) => Center(child: Text(index.toString().padLeft(2, '0'))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.isDateSelected.value = false;
                            },
                            child: Text('Kembali', style: GoogleFonts.nunito(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(120, 50),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () => controller.confirmSelection(context),
                            child: Text('Pilih Jam', style: GoogleFonts.nunito(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.appPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(120, 50),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
