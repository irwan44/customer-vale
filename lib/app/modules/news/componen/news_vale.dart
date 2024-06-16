import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../componen/color.dart';
import '../../../routes/app_pages.dart';

class NewsHelp extends StatefulWidget {
  const NewsHelp({super.key});

  @override
  State<NewsHelp> createState() => _NewsHelpState();
}

class _NewsHelpState extends State<NewsHelp> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body:
        WebView(
          initialUrl: 'https://vale.com/in/indonesia/all-news',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>{
            _createOpenLinkJavascriptChannel(context),
          },
        )
    );
  }

  JavascriptChannel _createOpenLinkJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'OpenLink',
        onMessageReceived: (JavascriptMessage message) {
          _launchURL(message.message);
        });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}