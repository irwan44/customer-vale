import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../componen/color.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isLoading = true; // Variable to manage loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // <-- SEE HERE
          statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
          systemNavigationBarColor: Colors.transparent,
        ),
        elevation: 0,
        actionsIconTheme: const IconThemeData(size: 20),
        backgroundColor: Colors.transparent,
        title: Text(
          'Help Center',
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://vale.com/in/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageStarted: (String url) {
              setState(() {
                isLoading = true; // Show loading indicator
              });
            },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false; // Hide loading indicator
              });
            },
            javascriptChannels: <JavascriptChannel>{
              _createOpenLinkJavascriptChannel(context),
            },
          ),
          isLoading // Display loading indicator
              ? Center(child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: MyColors.appPrimaryColor,),
                SizedBox(height: 10,),
                Text('Memuat Halaman')
                ]
             ),
          )
              : Stack(),
        ],
      ),
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
