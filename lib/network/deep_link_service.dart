import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> deepLinkService(BuildContext context) async {
  try {
    final Uri? initialUri = await getInitialUri();
    if (initialUri != null) {
      if (initialUri.pathSegments.first != 'store') {
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  try {
    uriLinkStream.listen((Uri? uri) {
      if (uri == null) return;
      processAppLink(context, uri);
    });
  } catch (e) {
    debugPrint(e.toString());
  }
}

/// Func to process the deep link
/// Eg. `https://gigavus.hydrameet.net/v/621c8d304c31e1001b6be8cb`
void processAppLink(BuildContext context, Uri uri, {bool replace = false}) async {
  // var pathSegments = uri.pathSegments;
  // var queryParameters = uri.queryParameters;
  closeInAppWebView();
}
