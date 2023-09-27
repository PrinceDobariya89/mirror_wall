import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/main.dart';
import 'package:mirror_wall/model/webview.dart';
import 'package:mirror_wall/utils/urls.dart';

class WebViewProvider extends ChangeNotifier {
  double progress = 0;
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? webViewController;
  String url = google;
  List<dynamic> bookmark = [];
  TextEditingController searchController = TextEditingController();
  void setProgress(double p) {
    progress = p;
    notifyListeners();
  }

  void loadUrl(String searchUrl) {
    webViewController?.loadUrl(
      urlRequest:
          URLRequest(url: Uri.parse('$searchUrl${searchController.text}')),
    );
  }

  void changeEngine(String? value) {
    switch (value) {
      case google:
        url = google;
        webViewController?.loadUrl(
            urlRequest: URLRequest(url: Uri.parse(google)));
        break;
      case yahoo:
        url = yahoo;
        webViewController?.loadUrl(
            urlRequest: URLRequest(url: Uri.parse(yahoo)));
        break;
      case bing:
        url = bing;
        webViewController?.loadUrl(
            urlRequest: URLRequest(url: Uri.parse(bing)));
        break;
      case duckduckgo:
        url = duckduckgo;
        webViewController?.loadUrl(
            urlRequest: URLRequest(url: Uri.parse(duckduckgo)));
        break;
      default:
        url = google;
    }
    notifyListeners();
  }

  void addBookmark(WebviewData data) {
    bookmark.add(data);
    setPref();
    notifyListeners();
  }

  void removeBookmark(WebviewData data) {
    bookmark.remove(data);
    setPref();
    notifyListeners();
  }

  void setPref() {
    List<String> save = bookmark.map((e) => jsonEncode(e.toJson())).toList();
    pref.setStringList('bookmark', save);
  }

  void readPref() {
    List<String>? data = pref.getStringList('bookmark');
    if (data != null) {
      bookmark = data.map((e) => WebviewData.fromJson(jsonDecode(e))).toList();
    }
  }
}
