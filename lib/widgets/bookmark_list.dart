import 'package:flutter/cupertino.dart';
import 'package:mirror_wall/controller/webview_provider.dart';
import 'package:mirror_wall/model/webview.dart';
import 'package:mirror_wall/widgets/bookmark.dart';
import 'package:provider/provider.dart';

class BookmarkList extends StatelessWidget {
  const BookmarkList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WebViewProvider>(
      builder: (context, value, child) {
        if (value.bookmark.isEmpty) {
          return Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: const Text('No any bookmarks yet...'));
        }
        return ListView.builder(
          itemCount: value.bookmark.length,
          itemBuilder: (context, index) {
            WebviewData data = value.bookmark[index];
            return Bookmark(data: data);
          },
        );
      },
    );
  }
}
