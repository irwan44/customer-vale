import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_bengkelly/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../componen/color.dart';
import '../../../../data/dummy_data.dart';
class LihatSemuaSpesialis extends StatefulWidget {
  const LihatSemuaSpesialis({super.key});

  @override
  State<LihatSemuaSpesialis> createState() => _LihatSemuaSpesialisState();
}

class _LihatSemuaSpesialisState extends State<LihatSemuaSpesialis> {
  int _currentIndex = 0;
  String _currentAddress = 'Mengambil lokasi...';
  Position? _currentPosition;
  final List<String> imgList = [
    'assets/images/slide-2.jpg',
    'assets/images/slide-3.jpg',
    'assets/images/slider1.png',
    'assets/images/promo1.jpeg',
  ];
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController =
        RefreshController();
  }

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
        title: Text('Semua Spesialis Offer'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Slider(context),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Spesialis Offer', style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 17, color: MyColors.appPrimaryColor)),
                      SlideCountdownSeparated(
                        duration: const Duration(days: 1),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth < 600 ? 2 : 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0.9,
                    childAspectRatio: 0.57,
                  ),
                  itemCount: dataProduct.length,
                  itemBuilder: (context, index) {
                    final product = dataProduct[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAILSPECIAL,
                            arguments:
                            {
                              'description': product['description'],
                              'name': product['name'],
                              'image': product['image'],
                              'Harga': product['Harga'],
                              'harga_asli': product['harga_asli'],
                              'diskon': product['diskon'],
                            }
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                        decoration: const BoxDecoration(
                        color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child :
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 475),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              child: SlideAnimation(
                                child: widget,
                              ),
                            ),
                            children: [
                              Image.asset(product['image'], fit: BoxFit.cover, height: 120, width: double.infinity),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                              Text(product['name'], style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                              Text(product['Harga'], style: GoogleFonts.nunito(color: Colors.green)),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green
                                    ),
                                    child: Text('${product['diskon']}', style: GoogleFonts.nunito(color: Colors.white)),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Rp ${product['harga_asli']}', style: GoogleFonts.nunito(decoration: TextDecoration.lineThrough)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 5),
                                  Text('4.9 ${product['terjual']} Terjual', style: GoogleFonts.nunito(color: Colors.grey)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.shield_moon_rounded, color: Colors.green),
                                  SizedBox(width: 5),
                                  Text('Dilayani Bengkelly', style: GoogleFonts.nunito(color: Colors.grey)),
                                ],
                              ),
                              ],),),
                            ],
                          ),
                        ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
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
                image:  AssetImage(item),
                fit: BoxFit.cover,
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 10),
        Container(
          width: 100,
          decoration: BoxDecoration(
            color: MyColors.slider,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 19.0,
                height: 5.0,
                margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  color: _currentIndex == index ? MyColors.appPrimaryColor : MyColors.slider,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
