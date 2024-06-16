import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../componen/custom_widget.dart';
import '../../../data/data_endpoint/profile.dart';
import '../../../data/endpoint.dart';
import '../../authorization/componen/fade_animationtest.dart';
import '../controllers/profile_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Profile>(
                future: API.profileiD(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: MyColors.appPrimaryColor,
                        ),
                        SizedBox(height: 10,),
                        Text('Sedang memuat data...')
                      ],)
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.data != null) {
                      final gambar = snapshot.data!.data?.gambar ?? "";
                      final nama = snapshot.data!.data?.nama ?? "";
                      final email = snapshot.data!.data?.email ?? "";
                      final hp = snapshot.data!.data?.hp ?? "";
                      final alamat = snapshot.data!.data?.alamat ?? "";

                      nameController.text = nama;
                      emailController.text = email;
                      hpController.text = hp;
                      alamatController.text = alamat;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GetBuilder<ProfileController>(
                            builder: (controller) {
                              return Stack(
                                alignment: const Alignment(0.9, 0.9),
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: controller.selectedImage != null
                                        ? FileImage(controller.selectedImage!)
                                        : NetworkImage(gambar) as ImageProvider,
                                    radius: 50.0,
                                  ),
                                  Container(
                                    height: 30.0,
                                    width: 30.0,
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: controller.pickImage,
                                      child: SvgPicture.asset(
                                        'assets/logo/Edit.svg',
                                        width: 46,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Text('Ganti Foto', style: GoogleFonts.nunito(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor),),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Nama'),
                              Container(
                                decoration: BoxDecoration(
                                  color: MyColors.bgform,
                                  border: Border.all(color: MyColors.bgformborder),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(18),
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Nomor Handphone'),
                              Container(
                                decoration: BoxDecoration(
                                  color: MyColors.bgform,
                                  border: Border.all(color: MyColors.bgformborder),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: hpController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(18),
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Email'),
                              Container(
                                decoration: BoxDecoration(
                                  color: MyColors.bgform,
                                  border: Border.all(color: MyColors.bgformborder),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(18),
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Alamat'),
                              Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  color: MyColors.bgform,
                                  border: Border.all(color: MyColors.bgformborder),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  height: 200,
                                  child: TextFormField(
                                    controller: alamatController,
                                    maxLines: null,
                                    expands: true,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(18),
                                      border: InputBorder.none,
                                      hintStyle: GoogleFonts.nunito(color: Colors.grey),
                                      hintText: 'Keluhan',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              controller.updateProfile(
                                nameController.text,
                                emailController.text,
                                hpController.text,
                                alamatController.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.appPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 4.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  'Update Profile',
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text('Tidak ada data');
                    }
                  }
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
