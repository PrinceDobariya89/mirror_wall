import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/main.dart';
import 'package:mirror_wall/model/webview.dart';
import 'package:mirror_wall/utils/urls.dart';

class WebViewProvider extends ChangeNotifier{
  double progress = 0;
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? webViewController;
  String url = google; 
  List<WebviewData> bookmark = [];

  void setProgress(double p){
    progress = p;
    notifyListeners();
  }

  void changeEngine(String? value){
    switch(value){
      case google:
      url = google;
      webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(google)));
      break;
      case yahoo:
      url = yahoo;
      webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(yahoo)));
      break;
      case bing:
      url = bing;
      webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(bing)));
      break;
      case duckduckgo:
      url = duckduckgo;
      webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(duckduckgo)));
      break;
      default:
      url = google;
    }
    notifyListeners();
  }

  void addBookmark(WebviewData data) {
    bookmark.add(data);
    saveBookmark();
    notifyListeners();
  }

  void removeBookmark(WebviewData data){
    bookmark.remove(data);
    notifyListeners();
  }

  saveBookmark(){
    List<String> bookmarkList = bookmark.map((e) => jsonEncode(e.toJson().toString())).toList();
    pref.setStringList('bookmark', bookmarkList);
  }

  readBookmark(){
    List<String>? bookmarkList = pref.getStringList('bookmark');
    // print(bookmarkList);
    if(bookmarkList != null){
      bookmark = bookmarkList.map((e) => WebviewData.fromJson(jsonDecode(e))).toList();
      print(bookmark);
      // print(data);      
    }
  }

  removePref(){

  }

}