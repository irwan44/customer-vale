import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/data_endpoint/news.dart';
import '../../../data/endpoint.dart';
import '../detail/detail_news.dart';

class TrandingTopik extends StatefulWidget {
  const TrandingTopik({super.key});

  @override
  State<TrandingTopik> createState() => _TrandingTopikState();
}

class _TrandingTopikState extends State<TrandingTopik> {
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
        itemCount: posts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          Post post = posts[index];
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
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        post.imageUrl ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            post.articleSection?.join(', ') ?? '',
                            style: GoogleFonts.nunito(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          post.title ?? '',
                          style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
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
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 15,
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
