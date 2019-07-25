import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(AzanApp());

class AzanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xF01BA2DD));
    return MaterialApp(
      title: 'Азан.қаз',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: WebView(
          initialUrl: 'https://azan.kz',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      onWillPop: () async {
        var c = await _controller.future;
        if (await c.canGoBack()) {
          await c.goBack();
          return false;
        }
        return true;
      },
    );
  }
}
