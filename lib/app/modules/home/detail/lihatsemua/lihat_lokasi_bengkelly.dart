import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_bengkelly/app/componen/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/dummy_data.dart';
import '../../../../routes/app_pages.dart';

class SemuaLokasiBengkelly extends StatefulWidget {
  const SemuaLokasiBengkelly({super.key});

  @override
  State<SemuaLokasiBengkelly> createState() => _SemuaLokasiBengkellyState();
}

class _SemuaLokasiBengkellyState extends State<SemuaLokasiBengkelly> {
  int _currentIndex = 0;
  final List<String> imgList = [
    'assets/228a/s228a-1.jpg',
    'assets/319b/s319b-1.jpg',
    'assets/379a/s379a-2.jpg',
    'assets/389b/s389b-2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Text(
          'Rest Area',
          style: GoogleFonts.nunito(
            color: MyColors.appPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Slider(context),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  Text(
                    'Lokasi Bengkelly',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: MyColors.appPrimaryColor,
                         ),
                      ),
                    Text(
                      'Terdapat 4 lokasi Bengkelly',
                      style: GoogleFonts.nunito(
                        color: MyColors.appPrimaryColor,
                      ),
                    ),
                    ]
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.LOKASIBENGKELLY);
                    },
                    child:
                  Column(children: [
                    Image.asset('assets/icons/drop.png', width: 40),
                    Text(
                      'Cek lokasi Bengkelly',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        color: MyColors.appPrimaryColor,
                      ),
                    ),
                    ],
                  ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 30),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: restAreaPlace.length,
              itemBuilder: (context, index) {
                final restArea = restAreaPlace[index];
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 475),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: Image.asset(
                            restArea['logo'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            restArea['name'],
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            restArea['address'],
                            style: GoogleFonts.nunito(),
                          ),
                          onTap: () {
                            Get.toNamed(
                              Routes.DETAILLOKASIBENGKELLY,
                              arguments: {
                                'id': restArea['id'],
                                'description': restArea['description'],
                                'name': restArea['name'],
                                'sliderImages': restArea['sliderImages'],
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _Slider(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.7,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: imgList.map((item) => Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(item),
                fit: BoxFit.cover,
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 19.0,
              height: 5.0,
              margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _currentIndex == index ? MyColors.appPrimaryColor : MyColors.slider,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
