import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../componen/color.dart';
import '../../../routes/app_pages.dart';
import '../componen/newsslider.dart';
import '../componen/trandingtopik.dart';
import '../controllers/news_controller.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final NewsController controller = Get.put(NewsController());
  int _currentIndex = 0;
  final List<String> imgList = [
    'https://via.placeholder.com/600x400.png?text=Image+1',
    'https://via.placeholder.com/600x400.png?text=Image+2',
    'https://via.placeholder.com/600x400.png?text=Image+3',
    'https://via.placeholder.com/600x400.png?text=Image+4',
  ];
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController =
        RefreshController(); // we have to use initState because this part of the app have to restart
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.checkForUpdate();
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('News', style: GoogleFonts.nunito(color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),),
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
      SingleChildScrollView(
    child:
      Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 475),
          childAnimationBuilder: (widget) => SlideAnimation(
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            newsslider(),
            SizedBox(height: 20),
            _sectionTitle('Tranding Topic'),
            SizedBox(height: 20),
            TrandingTopik(),
          ],
        ),
      ),
      ),
      ),
    );
  }
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 17, color: MyColors.appPrimaryColor)),
        ],
      ),
    );
  }
  _onLoading() {
    _refreshController
        .loadComplete(); // after data returned,set the //footer state to idle
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {

      NewsView();
      _refreshController
          .refreshCompleted();
    });
  }
}
