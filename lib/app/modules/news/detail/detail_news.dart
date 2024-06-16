import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html_v3/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../componen/color.dart';
import '../../../data/data_endpoint/news.dart';
import '../../../data/endpoint.dart';

class DetailsNews extends StatelessWidget {
  final Post? data;

  const DetailsNews({
    super.key,
    this.data,
  });
  String formatDateNoTime(DateTime? valueData) {
    return valueData != null
        ? DateFormat(
      'dd MMMM yyyy',
    ).format(valueData)
        : "-";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildBody(context, data),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
        systemNavigationBarColor:  Colors.transparent,
      ),
      elevation: 0,
      // leadingWidth: 45,
      actionsIconTheme: const IconThemeData(size: 20),
      title: Text(
        'News',
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
          color: MyColors.appPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Post? data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context),
          const SizedBox(
            height: 10,
          ),
          _buildContent(),
          _buildDescription(context),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Hero(
      tag: data?.title ?? '',
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              '${data?.imageUrl}',
              loadingBuilder:
                  (context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return CircularProgressIndicator(
                  backgroundColor: MyColors.appPrimaryColor,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Author: ${data?.author}',
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: MyColors.grey,
            ),
          ),
          Text(
            'Category: ${data?.category}',
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: MyColors.grey,
            ),
          ),
          Text(
            'Date: ${formatDateNoTime(data?.date)}',
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: MyColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Html(
              data: '${data?.content}',
              style: {
                "body": Style(
                  fontFamily: 'Nunito',
                ),
                "#ez-toc-container": Style(
                  display: Display.none,
                ),
              },
              onLinkTap: (String? url, _, __, ___) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WebViewNewsPage(
                //       url: url,
                //     ),
                //   ),
                // );
                _launchURL(url ?? '');
                debugPrint(url);
              },
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
