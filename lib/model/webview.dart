import 'dart:convert';

class WebviewData {
  List<WebviewData> webviewDataFromJson(String str) => List<WebviewData>.from(
      json.decode(str).map((x) => WebviewData.fromJson(x)));

  String webviewDataToJson(List<WebviewData> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  String? title;
  String? link;
  WebviewData({required this.title, required this.link});

  factory WebviewData.fromJson(Map<String, dynamic> json) =>
      WebviewData(title: json["title"], link: json["link"]);

  Map<String, dynamic> toJson() => {"title": title, "link": link};
}
