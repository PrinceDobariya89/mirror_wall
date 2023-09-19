import 'package:flutter/material.dart';
import 'package:mirror_wall/controller/webview_provider.dart';
import 'package:mirror_wall/model/webview.dart';
import 'package:provider/provider.dart';

class Bookmark extends StatelessWidget {
  final WebviewData data;
  const Bookmark({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<WebViewProvider>(builder: (context, value, child) {
      return ListTile(
        onTap: (){
          value.readBookmark();
        },
      title: Text(data.title ?? 'title not found'),
      subtitle: Text(data.link.toString()),
      trailing: IconButton(onPressed: (){
        value.removeBookmark(data);
      }, icon: const Icon(Icons.close_rounded)),
    );
    },);
  }
}
