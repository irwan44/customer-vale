import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/data_endpoint/news.dart';
import '../../../data/endpoint.dart';
import '../detail/detail_news.dart';

class TodayDeals extends StatefulWidget {
  const TodayDeals({super.key});

  @override
  State<TodayDeals> createState() => _TodayDealsState();
}

class _TodayDealsState extends State<TodayDeals> {
  final ScrollController _scrollController = ScrollController();
  final List<Post> _posts = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _loadPosts();
      }
    });
  }

  void _loadPosts() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Post> newPosts = await API.fetchBengkellyPosts(
          page:
              _currentPage); // Change this to fetchFleetMaintenancePosts to load posts from Fleet Maintenance
      setState(() {
        _currentPage++;
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
    return _isLoading && _posts.isEmpty
        ? _buildShimmerItem()
        : _gridView(context, _posts);
  }
  Widget _gridView(BuildContext context, List<Post> posts) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (posts.isEmpty) {
            return _buildShimmerItem();
          } else {
            Post post = posts[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
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
                  height: 190,
                  decoration: BoxDecoration(
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
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.5 * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          image: DecorationImage(
                            image: NetworkImage(post.imageUrl ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 8,),
                            Text(
                              post.title ?? '',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],),)
                    ],),
                ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  Widget _buildShimmerItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 190,
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
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
