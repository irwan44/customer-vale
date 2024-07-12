import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../componen/custom_widget.dart';
import '../../../data/data_endpoint/kategorikendaraan.dart';
import '../../../data/data_endpoint/merekkendaraan.dart';
import '../../../data/data_endpoint/tipekendaraan.dart';
import '../../../data/endpoint.dart';
import '../controllers/authorization_controller.dart';
import 'common.dart';
import 'fade_animationtest.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  final AuthorizationController controller = Get.put(AuthorizationController());

  @override
  Widget build(BuildContext context) {
    List<String> tipeList = ["AT", "MT"];
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
                          "Registrasi Kendaraan Anda",
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
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: controller.nopolController,
                              obscureText:false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(18),
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                  hintText: 'Nomor Polisi'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: controller.hpController,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(18),
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                  hintText: 'Nomor Handphone'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.bgformborder),
                                borderRadius: BorderRadius.circular(10)),
                            child: FutureBuilder<MerekKendaraan>(
                              future: controller.futureMerek.value,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                                  return Center(child: Text('No data available'));
                                } else {
                                  List<Data> merekList = snapshot.data!.data!;
                                  List<String> namaMerekList = merekList.map((merek) => merek.namaMerk!).toList();
                                  print("Nama Merk List: $namaMerekList");

                                  return CustomDropdown.search(
                                    hintText: 'Merek',
                                    items: namaMerekList,
                                    onChanged: (value) {
                                      controller.selectedMerek.value = value!;
                                      try {
                                        // Find the ID of the selected merek
                                        controller.selectedMerekId.value =
                                        merekList.firstWhere((merek) => merek.namaMerk == value).id!;
                                        // Trigger load for dropdown 2
                                        controller.futureTipeKendaraan.value =
                                            API.tipekendaraanID(id: controller.selectedMerekId.value);
                                        print("Selected Merek ID: ${controller.selectedMerekId.value}");
                                      } catch (e) {
                                        print("Error: $e");
                                        controller.selectedMerekId.value = 0;
                                        controller.futureTipeKendaraan.value = Future<TipeKendaraan>.value(TipeKendaraan(data: []));
                                      }
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() => controller.selectedMerekId.value == 0
                            ? Container() // Show nothing if no item is selected in dropdown 1
                            : FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.bgformborder),
                                borderRadius: BorderRadius.circular(10)),
                            child: FutureBuilder<TipeKendaraan>(
                              future: controller.futureTipeKendaraan.value,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                                  return Center(child: Text('No data available'));
                                } else {
                                  List<DataTipe> tipeList = snapshot.data!.data!;
                                  List<String> namaTipeList = tipeList.map((tipe) => tipe.namaTipe!).toList();
                                  print("Nama Tipe List: $namaTipeList");

                                  return CustomDropdown.search(
                                    hintText: 'Tipe',
                                    items: namaTipeList,
                                    onChanged: (value) {
                                      controller.selectedTipeID.value =
                                      tipeList.firstWhere((merek) => merek.namaTipe == value).id!;
                                      controller.selectedTipe.value = value!;
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder),
                            ),
                            child: FutureBuilder<KategoryKendaraan>(
                              future: API.kategorykendaraanID(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.dataKategoriKendaraan!.isEmpty) {
                                  return Center(child: Text('No data available'));
                                } else {
                                  List<DataKategoriKendaraan> tipeList = snapshot.data!.dataKategoriKendaraan!;
                                  List<String> KategoryList = tipeList.map((tipe) => tipe.kategoriKendaraan!).toList();
                                  print("Nama Kategory List: $KategoryList");

                                  return CustomDropdown.search(
                                    hintText: 'Kategory Kendaraan',
                                    items: KategoryList,
                                    onChanged: (value) {
                                      controller.selectedKategory.value = value!;
                                      print("Selected Kategori: ${controller.selectedKategory.value}");
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.bgformborder),
                                borderRadius: BorderRadius.circular(10)),
                            child: CustomDropdown.search(
                              hintText: 'Transmisi Kendaraan',
                              items: tipeList,
                              onChanged: (value) {
                                controller.selectedTransmisi.value = value!;
                                print("Selected Tipe: ${controller.selectedTransmisi.value}");
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child:  Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            TextFormField(
                              controller: controller.vinnumberController,
                              obscureText:false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(18),
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                  hintText: 'Vin Number'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: controller.tahunController,
                              keyboardType: TextInputType.number,
                              obscureText:false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(18),
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                  hintText: 'Tahun'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 1.8,
                          child:  Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.bgformborder),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: controller.warnaController,
                              obscureText:false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(18),
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                  hintText: 'Warna'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInAnimation(
                          delay: 2.7,
                          child: Obx(() => CustomElevatedButton(
                            message: "Register",
                            function: controller.isRegisterFormValid.value
                                ? () async {
                              await controller.register();
                            }
                                : () async {},
                            color: controller.isRegisterFormValid.value
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
