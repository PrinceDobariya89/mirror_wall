import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/controller/webview_provider.dart';
import 'package:mirror_wall/model/webview.dart';
import 'package:mirror_wall/utils/urls.dart';
import 'package:mirror_wall/widgets/bookmark_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<WebViewProvider>(context, listen: false).readPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WebViewProvider>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('My Browser'),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      value: 0,
                      onTap: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          isScrollControlled: true,
                          context: context,
                          showDragHandle: true,
                          builder: (context) {
                            return const BookmarkList();
                          },
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.bookmark),
                          SizedBox(width: 10),
                          Text('All Bookmark'),
                        ],
                      )),
                  PopupMenuItem(
                      onTap: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Search Engine',
                                      style: TextStyle(fontSize: 25)),
                                  RadioListTile(
                                      value: google,
                                      groupValue: provider.url,
                                      onChanged: (value) {
                                        Navigator.pop(context);
                                        provider.changeEngine(value);
                                      },
                                      title: const Text('Google')),
                                  RadioListTile(
                                      value: yahoo,
                                      groupValue: provider.url,
                                      onChanged: (value) {
                                        Navigator.pop(context);
                                        provider.changeEngine(value);
                                      },
                                      title: const Text('Yahoo')),
                                  RadioListTile(
                                      value: bing,
                                      groupValue: provider.url,
                                      onChanged: (value) {
                                        Navigator.pop(context);
                                        provider.changeEngine(value);
                                      },
                                      title: const Text('Bing')),
                                  RadioListTile(
                                      value: duckduckgo,
                                      groupValue: provider.url,
                                      onChanged: (value) {
                                        Navigator.pop(context);
                                        provider.changeEngine(value);
                                      },
                                      title: const Text('Duck Duck Go'))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.screen_search_desktop_rounded),
                          SizedBox(width: 10),
                          Text('Search Engine'),
                        ],
                      )),
                ];
              },
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<WebViewProvider>(
                builder: (context, wc, child) => CupertinoSearchTextField(
                  controller: wc.searchController,
                  onSubmitted: (value) {
                    switch (wc.url) {
                      case google:
                        wc.loadUrl(searchGoogle);
                        break;
                      case yahoo:
                        wc.loadUrl(searchYahoo);
                        break;
                      case bing:
                        wc.loadUrl(searchBing);
                        break;
                      case duckduckgo:
                        wc.loadUrl(searchDuckduckgo);
                        break;
                      default:
                        wc.loadUrl(searchGoogle);
                    }
                  },
                ),
              ),
              Consumer<WebViewProvider>(
                builder: (context, value, child) {
                  if (value.progress != 1) {
                    return LinearProgressIndicator(value: value.progress);
                  }
                  return const SizedBox();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.home_rounded)),
                  Consumer<WebViewProvider>(
                    builder: (context, value, child) {
                      return IconButton(
                          onPressed: () async {
                            String? title =
                                await value.webViewController?.getTitle();
                            Uri? uri = await value.webViewController?.getUrl();
                            value.addBookmark(WebviewData(
                                title: title.toString(), link: uri.toString()));
                          },
                          icon: const Icon(Icons.bookmark_add_outlined));
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        provider.webViewController?.goBack();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  IconButton(
                      onPressed: () {
                        provider.webViewController?.reload();
                      },
                      icon: const Icon(Icons.refresh_rounded)),
                  IconButton(
                      onPressed: () {
                        provider.webViewController?.goForward();
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded)),
                ],
              ),
            ],
          ),
        ),
        body: Consumer<WebViewProvider>(
          builder: (context, value, child) {
            return InAppWebView(
              pullToRefreshController: PullToRefreshController(onRefresh: () {
                value.webViewController?.reload();
              }),
              onProgressChanged: (controller, progress) {
                value.setProgress(progress / 100);
                if (value.progress == 100) {
                  value.pullToRefreshController?.endRefreshing();
                }
              },
              onWebViewCreated: (controller) {
                value.webViewController = controller;
              },
              onLoadStop: (controller, url) =>
                  value.pullToRefreshController?.endRefreshing(),
              initialUrlRequest: URLRequest(url: Uri.parse(value.url)),
            );
          },
        ));
  }
}
