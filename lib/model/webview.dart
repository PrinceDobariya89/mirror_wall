class WebviewData {
  String? title;
  String? link;
  WebviewData({required this.title, required this.link});

  factory WebviewData.fromJson(Map<String, dynamic> json) =>
      WebviewData(title: json["title"], link: json["link"]);
      
  Map<String, dynamic> toJson() => {"title": title, "link": link};
}
