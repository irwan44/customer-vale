import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/booking_controller.dart';
import '../../../data/data_endpoint/customkendaraan.dart';

class ListKendaraanWidget extends StatelessWidget {
  final BookingController controller = Get.find<BookingController>();
  final TextEditingController searchController = TextEditingController();

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
            SizedBox(height: 60,),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Pilih Kendaraan',
                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Cari berdasarkan nomor polisi...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  controller.search(query);
                },
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
              child: ListView.builder(
                itemCount: controller.filteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  DataKendaraan item = controller.filteredList[index];
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
                      controller.resetSearch();
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
