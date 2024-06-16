import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/data_endpoint/news.dart';
import '../../../data/endpoint.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
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
        ? const Center(child: CircularProgressIndicator())
        : _newsListView(context, _posts);
  }

  Widget _newsListView(BuildContext context, List<Post> posts) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          Post post = posts[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(post.imageUrl??""), // Gunakan URL gambar dari data post
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                height: 140,
                alignment: Alignment.center,
              ),
              SizedBox(height: 8), // Jarak antara container dan teks
              Text(
                post.title ?? '',
                style: GoogleFonts.nunito(
                  fontSize: 14.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
            ],
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
