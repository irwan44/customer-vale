import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/data_endpoint/customkendaraan.dart';
import '../../../data/data_endpoint/kendaraandepartemen.dart';
import '../../../data/data_endpoint/kendaraanpic.dart';
import '../controllers/booking_controller.dart';

class ListKendaraanWidget extends StatelessWidget {
  final BookingController controller = Get.find<BookingController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible:
          !(controller.isLoading.value || controller.tipeListDepartemen.isEmpty),
          child: Expanded( // Wrap with Expanded to occupy remaining space
            child: Container(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.tipeListDepartemen.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
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
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredListDepartemen.length,
                          itemBuilder: (BuildContext context, int index) {
                            KendaraanDepartemen item =
                            controller.filteredListDepartemen[index];
                            bool isSelected =
                                item == controller.selectedTransmisiPIC.value;
                            return ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    item.namaMerk ?? '',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' - ',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.namaTipe ?? '',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                'No Polisi: ${item.noPolisi}\nWarna: ${item.warna} - Tahun: ${item.tahun}\nNomor Lambung: ${item.vinNumber??'Tidak ada nomor Lambung'}',
                              ),
                              trailing: isSelected
                                  ? Icon(Icons.check, color: Colors.green)
                                  : null,
                              onTap: () {
                                controller.selectedTransmisiDepartemen(item);
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
              }),
            ),
          ),
        ),
        Visibility(
          visible:
          !(controller.isLoading.value || controller.tipeListPIC.isEmpty),
          child: Expanded( // Wrap with Expanded to occupy remaining space
            child: Container(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.tipeListPIC.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
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
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredListPIC.length,
                          itemBuilder: (BuildContext context, int index) {
                            Kendaraanpic item =
                            controller.filteredListPIC[index];
                            bool isSelected =
                                item == controller.selectedTransmisiPIC.value;
                            return ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    item.namaMerk ?? '',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ' - ',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.namaTipe ?? '',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                'No Polisi: ${item.noPolisi}\nWarna: ${item.warna} - Tahun: ${item.tahun}\nNomor Lambung: ${item.vinNumber??'Tidak ada nomor Lambung'}',
                              ),
                              trailing: isSelected
                                  ? Icon(Icons.check, color: Colors.green)
                                  : null,
                              onTap: () {
                                controller.selectedTransmisiPIC(item);
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
              }),
            ),
          ),
        ),
        Visibility(
          visible: !(controller.isLoading.value || controller.tipeList.isEmpty),
          child: Expanded( // Wrap with Expanded to occupy remaining space
            child: Container(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.tipeList.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
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
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredList.length,
                          itemBuilder: (BuildContext context, int index) {
                            DataKendaraan item = controller.filteredList[index];
                            bool isSelected =
                                item == controller.selectedTransmisi.value;
                            return ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...(item.tipes ?? []).map((tipe) => Text(
                                    '${item.merks?.namaMerk} - ${tipe.namaTipe}',
                                    maxLines: 2,
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                'No Polisi: ${item.noPolisi}\nWarna: ${item.warna} - Tahun: ${item.tahun}\nNomor Lambung: ${item.vinnumber??'Tidak ada nomor Lambung'}',
                              ),
                              trailing: isSelected
                                  ? Icon(Icons.check, color: Colors.green)
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
              }),
            ),
          ),
        ),
      ],
    );
  }
}
