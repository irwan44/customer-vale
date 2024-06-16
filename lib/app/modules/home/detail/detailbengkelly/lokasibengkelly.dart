import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_bengkelly/app/modules/home/detail/detailbengkelly/warung/tenants.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../componen/color.dart';

class DetailLokasiBengkelly extends StatefulWidget {
  @override
  State<DetailLokasiBengkelly> createState() => _DetailLokasiBengkellyState();
}

class _DetailLokasiBengkellyState extends State<DetailLokasiBengkelly> {
  late final String description;
  late final String id;
  late final String nama;
  late List<String> sliderImagesList;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    description = arguments['description'];
    id = arguments['id'];
    nama = arguments['name'];
    sliderImagesList = List<String>.from(arguments['sliderImages']);
  }

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
        title: const Text('Rest Area'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: ArgumentsLokasi(
          description: description,
          nama: nama,
          sliderImages: sliderImagesList,
          id: id,
        ),
      ),
    );
  }
}

class ArgumentsLokasi extends StatelessWidget {
  final String description;
  final String id;
  final String nama;
  final List<String> sliderImages;

  const ArgumentsLokasi(
      {Key? key,
        required this.description,
        required this.nama,
        required this.sliderImages,
        required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Slider(sliderImages: sliderImages),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama,
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 10),
              Text(
                'Deskripsi',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),

              ExpandableText(
                description,
                expandText: 'Lihat Selengkapnya',
                collapseText: 'show less',
                maxLines: 5,
                linkColor: Colors.blue,
              ),
              SizedBox(height: 10),
              Text(
                'Fasilitas',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 10),
              SvgPicture.asset('assets/icons/icond.svg', width: 90),
              SizedBox(height: 10),
              Text(
                'Tenants',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 10),
              TenantListPage(
                restAreaId: id,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Slider extends StatefulWidget {
  final List<String> sliderImages;

  const _Slider({Key? key, required this.sliderImages}) : super(key: key);

  @override
  __SliderState createState() => __SliderState();
}

class __SliderState extends State<_Slider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
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
                _current = index;
              });
            },
          ),
          items: widget.sliderImages.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
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
            children: widget.sliderImages.map((image) {
              int index = widget.sliderImages.indexOf(image);
              return Container(
                width: 19.0,
                height: 5.0,
                margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  color: _current == index
                      ? MyColors.appPrimaryColor
                      : MyColors.slider,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
