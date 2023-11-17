import 'package:flutter/cupertino.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: HomePage(),
      theme: CupertinoThemeData(brightness: Brightness.light),
    );
  }
}
