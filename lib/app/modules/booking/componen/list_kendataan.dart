import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/booking_controller.dart';
import '../../../data/data_endpoint/customkendaraan.dart';

class ListKendaraanWidget extends StatelessWidget {
  final BookingController controller = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.tipeList.isEmpty) {
        return const Center(child: Text('No data available'));
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Pilih Kendaraan',
                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.tipeList.length,
                itemBuilder: (BuildContext context, int index) {
                  DataKendaraan item = controller.tipeList[index];
                  bool isSelected = item == controller.selectedTransmisi.value;
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          '${item.merks?.namaMerk}',
                          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' - ',
                          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                        ),
                        ...?item.tipes?.map((tipe) => Text(
                          '${tipe.namaTipe}',
                          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                        )).toList(),
                      ],
                    ),
                    subtitle: Text(
                        'No Polisi: ${item.noPolisi}\nWarna: ${item.warna} - Tahun: ${item.tahun}'
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () {
                      controller.selectTransmisi(item);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      }
    });
  }
}
