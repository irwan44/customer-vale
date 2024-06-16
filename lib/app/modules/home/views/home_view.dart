import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:customer_bengkelly/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../history/views/history_view.dart';
import '../../news/componen/news_vale.dart';
import '../../news/views/news_view.dart';
import '../../profile/views/profile_view.dart';
import 'page_home.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final List<Widget> _pages = [
    HomePage(),
    NewsHelp(),
    HistoryView(),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(""),
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: MyColors.appPrimaryColor,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: MyColors.appPrimaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildIconButton('assets/icons/octicon_home-16.svg', 'Home', 0),
            SizedBox(width: 10), // S
            _buildIconButton('assets/icons/mingcute_news-line.svg', 'News', 1),
            SizedBox(width: 90), // Space for FAB
            _buildIconButton('assets/icons/icon-park-outline_history-query.svg', 'History', 2),
            SizedBox(width: 10), // S
            _buildIconButton('assets/icons/gridicons_user.svg', 'Profile', 3),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 90, // Lebar FloatingActionButton
        height: 90, // Tinggi FloatingActionButton
        child:
        FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.EmergencyBookingView);
          },
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(706.0)),
          ),
          child:SizedBox(
            height: 130,
            child:
          SvgPicture.asset('assets/icons/booking.svg'),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildIconButton(String iconPath,String label, int index, ) {
    bool isSelected = _selectedIndex == index;
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: isSelected ? AnimatedContainer(
              duration: Duration(milliseconds: 300), // Durasi animasi
              curve: Curves.bounceIn,
              padding: EdgeInsets.all(10),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: MyColors.select,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                iconPath,
                color: MyColors.appPrimaryColor,
                width: 30, // Adjust icon size
                height: 30,
              ),
            ) : SvgPicture.asset(
              iconPath,
              color: Colors.white54,
              width: 24, // Regular icon size
              height: 24,
            ),
            onPressed: () => _onItemTapped(index),
          ),
          Text(label, style: GoogleFonts.nunito(color: Colors.white, fontSize: 12))
        ]
    );
  }
}
