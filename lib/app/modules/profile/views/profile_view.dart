import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../componen/ButtonSubmitWidget.dart';
import '../../../componen/color.dart';
import '../../../componen/profile_shimmer.dart';
import '../../../componen/spleshscreen.dart';
import '../../../data/data_endpoint/profile.dart';
import '../../../data/endpoint.dart';
import '../../../data/localstorage.dart';
import '../../../routes/app_pages.dart';
import '../../booking/controllers/booking_controller.dart';
import '../componen/test.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController controller = Get.put(ProfileController());
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController =
        RefreshController(); // we have to use initState because this part of the app have to restart
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Profile', style: GoogleFonts.nunito(color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.CHAT);
                },
                child:
                SvgPicture.asset('assets/icons/massage.svg', width: 26,),),
              SizedBox(width: 20,),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.NOTIFIKASI);
                },
                child:
                SvgPicture.asset('assets/icons/notif.svg', width: 26,),),
              SizedBox(width: 10,),
            ],),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const WaterDropHeader(),
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child:
        SingleChildScrollView(child:
        Column(children: [
          _Profile(),
          SizedBox(height: 20,),
          _setting(),
          SizedBox(height: 20,),
          _logout(context),
          SizedBox(height: 60,),
          Text('Aplikasi Versi ${controller.packageName}', style: GoogleFonts.nunito(color: MyColors.appPrimaryColor),),
        ],
        ),
        ),
      ),
    );
  }


  Widget _Profile() {
    return  InkWell(
      onTap: () {
        Get.toNamed(Routes.EDITPROFILE);
      },
      child:
      Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColors.card,
          borderRadius: BorderRadius.circular(20),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Profile>(
              future: API.profileiD(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ProfileLoadingShimmer();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.data != null) {
                    final gambar = snapshot.data!.data?.gambar ?? "";
                    final nama = snapshot.data!.data?.nama ?? "";
                    final email = snapshot.data!.data?.email ?? "";
                    final hp = snapshot.data!.data?.hp ?? "";
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: gambar != null
                                  ? Image.network(
                                gambar,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/profile.png',
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                                  : Image.asset(
                                'assets/images/profile.png',
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          nama,
                                          style: GoogleFonts.nunito(
                                            color: MyColors.appPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          'assets/icons/edit.svg',
                                          width: 26,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    email,
                                    style: GoogleFonts.nunito(
                                      color: MyColors.appPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    hp,
                                    style: GoogleFonts.nunito(
                                      color: MyColors.appPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const Text('Tidak ada data');
                  }
                }
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget _setting() {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.bg,
      ),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 475),
          childAnimationBuilder: (widget) => SlideAnimation(
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [

            InkWell(
              onTap: () {
                Get.toNamed(Routes.PILIHKENDARAAN);
              },
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/carset.svg', width: 26,),
                      SizedBox(width: 10,),
                      Text('Pilih Kendaraaan', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                    ],),

                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400,),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Divider(color: Colors.grey.shade300,),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.CHAT);
              },
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/tandaseru.svg', width: 26,),
                      SizedBox(width: 10,),
                      Text('Pusat Bantuan', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                    ],),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400,),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Divider(color: Colors.grey.shade300,),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Pengaturan Aplikasi', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: MyColors.bg,
                      ),
                      child:
                          InkWell(
                          onTap: () {
                            AppSettings.openAppSettings(
                                type: AppSettingsType.notification);
                    },
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.settings, color: Colors.grey.shade400, size: 20,),
                              SizedBox(width: 10,),
                              Text('Notifikasi', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                            ],),
                          Icon(Icons.notifications_active_rounded, color: Colors.grey.shade400, size: 20,),
                        ],
                      ),
                    ),
                    ),
                          SizedBox(height: 10,),
                          Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: MyColors.bg,
                          ),
                          child:
                          InkWell(
                            onTap: () {
                              AppSettings.openAppSettings(
                                  type: AppSettingsType.location);
                            },
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.settings, color: Colors.grey.shade400, size: 20,),
                                    SizedBox(width: 10,),
                                    Text('GPS', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                                  ],),
                                Icon(Icons.gps_fixed_rounded, color: Colors.grey.shade400, size: 20,),
                              ],
                            ),
                          ),
                          ),
                          SizedBox(height: 10,),
                    Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: MyColors.bg,
                    ),
                    child:
                          InkWell(
                            onTap: () {
                              AppSettings.openAppSettings(
                                  type: AppSettingsType.sound);
                            },
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.settings, color: Colors.grey.shade400, size: 20,),
                                    SizedBox(width: 10,),
                                    Text('Suara', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                                  ],),
                                Icon(Icons.surround_sound_rounded, color: Colors.grey.shade400, size: 20,),
                              ],
                            ),
                          ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    );
                  },
                );
              },
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/setting.svg', width: 26,),
                      SizedBox(width: 10,),
                      Text('Pengaturan', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _logout(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(30),
              height: 245,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Continue To Logout?",
                        style: GoogleFonts.nunito(
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Are you sure to logout from this device?",
                        style: GoogleFonts.nunito(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonSubmitWidget1(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        title: "No, cancel",
                        bgColor: Colors.white,
                        textColor: MyColors.appPrimaryColor,
                        fontWeight: FontWeight.normal,
                        width: 70,
                        height: 50,
                        borderSide: Colors.transparent,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonSubmitWidget2(
                        onPressed: () {
                          logout();
                        },
                        title: "Yes, Continue",
                        bgColor: MyColors.appPrimaryColor,
                        textColor: Colors.white,
                        fontWeight: FontWeight.normal,
                        width: 100,
                        height: 50,
                        borderSide: Colors.transparent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child:
      Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColors.bg,
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 475),
            childAnimationBuilder: (widget) => SlideAnimation(
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.logout_rounded, color: Colors.red,),
                      SizedBox(width: 10,),
                      Text('Log Out', style: GoogleFonts.nunito(fontWeight: FontWeight.bold, color: Colors.red),),
                    ],),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.redAccent,),
                ],
              ),],
          ),
        ),
      ),
    );
  }
  void logout() {
    // Bersihkan cache untuk setiap data yang Anda simpan dalam cache
    LocalStorages.deleteToken();

    // Navigasi ke halaman login
    Get.offAllNamed(Routes.SINGIN);
  }
  _onLoading() {
    _refreshController
        .loadComplete(); // after data returned,set the //footer state to idle
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {

      const ProfileView();
      _refreshController
          .refreshCompleted();
    });
  }
}
