import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/controller/webview_provider.dart';
import 'package:mirror_wall/model/webview.dart';
import 'package:provider/provider.dart';

class Bookmark extends StatelessWidget {
  final WebviewData data;
  const Bookmark({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<WebViewProvider>(
      builder: (context, value, child) {
        return ListTile(
          onTap: () {
            value.webViewController
                ?.loadUrl(
                    urlRequest:
                        URLRequest(url: Uri.parse(data.link.toString())))
                .then((value) => Navigator.pop(context));
          },
          title: Text(data.title ?? 'not found'),
          subtitle: Text(data.link.toString(),
              maxLines: 2, overflow: TextOverflow.ellipsis),
          trailing: IconButton(
              onPressed: () {
                value.removeBookmark(data);
              },
              icon: const Icon(Icons.close_rounded)),
        );
      },
    );
  }
}
