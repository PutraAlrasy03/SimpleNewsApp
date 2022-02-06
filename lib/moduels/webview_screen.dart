import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

  final String? url;

  WebViewScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
            Share.share('$url', subject: 'Artical URl');
          }, icon: Icon(Icons.share),iconSize: 18,),
        ],
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
