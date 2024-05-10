import 'package:flutter/material.dart';
import 'package:wechat_post/features/postedit/screens/post_edit_screen.dart';
import 'package:wechat_post/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wechat post Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // 设置底部弹出框的背景色为透明
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const PostEditScrren(),
    );
  }
}
