import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewService {
  static final WebViewService _instance = WebViewService._internal();
  factory WebViewService() => _instance;
  
  WebViewService._internal();

  InAppWebViewController? webViewController;

  void setController(InAppWebViewController controller) {
    webViewController = controller;
  }

  Future<void> loadUrl(String url) async {
    if (webViewController != null) {
      await webViewController!.loadUrl(
        urlRequest: URLRequest(url: WebUri(url)),
      );
    }
  }
}
