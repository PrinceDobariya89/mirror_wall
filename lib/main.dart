import 'package:flutter/material.dart';
import 'package:mirror_wall/controller/webview_provider.dart';
import 'package:mirror_wall/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WebViewProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mirror Walls',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ));
  }
}
