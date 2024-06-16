import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../componen/color.dart';
import '../../../data/data_endpoint/news.dart';
import '../../../data/endpoint.dart';
import '../detail/detail_news.dart';

class newsslider extends StatefulWidget {
  const newsslider({Key? key}) : super(key: key);

  @override
  State<newsslider> createState() => _newssliderState();
}

class _newssliderState extends State<newsslider> {
  int _currentIndex = 0;
  List<Post> _posts = [];
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Post> newPosts = await API.fetchBengkellyPosts(page: _posts.length ~/ 10 + 1);
      setState(() {
        _posts.addAll(newPosts);
        _isLoading = false;
        _hasMore = newPosts.length >= 10;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _isLoading && _posts.isEmpty
            ? _buildShimmerCarouselSlider()
            : _buildCarouselSlider(),
        const SizedBox(height: 10),
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider.builder(
      itemCount: _isLoading || _posts.isEmpty ? 4 : _posts.take(4).length,
      options: CarouselOptions(
        autoPlay: !_isLoading && _posts.length >= 4,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        aspectRatio: 1.4,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        if (_isLoading || _posts.isEmpty) {
          return _buildShimmerCarouselSlider();
        } else {
          Post post = _posts[index];
          return InkWell(
              onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsNews(
                  data: post,
                ),
              ),
            );
          },
        child:
            Container(
            margin: EdgeInsets.only(right: 10, top: 20, bottom: 20),
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
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(post.imageUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(''),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: 10, top: 10, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text('NEW', style: GoogleFonts.nunito(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor),),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: Text(post.title ?? '', style: GoogleFonts.nunito(fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_rounded, color: MyColors.appPrimaryColor,),
                      SizedBox(width: 10,),
                      Text(DateFormat('dd-MM-yyyy').format(post.date), style: GoogleFonts.nunito(fontWeight: FontWeight.bold, color: Colors.grey),),
                    ],
                  ),
                ),
              ],
            ),
            ),
          );
        }
      },
    );
  }

  Widget _buildShimmerCarouselSlider() {
    return CarouselSlider.builder(
      itemCount: 4,
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 1.4,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.only(right: 10, top: 20, bottom: 20),
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
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  height: 20,
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
                Container(
                  height: 20,
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
                Container(
                  height: 20,
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
                Container(
                  height: 20,
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildPageIndicator() {
    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: MyColors.slider,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _posts.asMap().entries.map((entry) {
          int index = entry.key;
          return Container(
            width: 19.0,
            height: 5.0,
            margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              color: _currentIndex == index ? MyColors.appPrimaryColor : MyColors.slider,
            ),
          );
        }).toList(),
      ),
    );
  }
}
