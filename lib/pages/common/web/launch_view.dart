import 'package:bizcard_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LaunchView extends StatefulWidget {
  final String url;
  const LaunchView({super.key, required this.url});

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> {

  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setUserAgent("Chrome/81.0.0.0 Mobile")
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onUrlChange: (v){
            if(v.url!=null && v.url!.contains('https://bizcard-spiderlingz.web.app/i/')){
              Navigator.pushNamedAndRemoveUntil(context, Routes.callback, (route) => false, arguments: v.url);
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url)); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        key: GlobalKey(),
        
        controller: controller
      ),
    );
  }
}