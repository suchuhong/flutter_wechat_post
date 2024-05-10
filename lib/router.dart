import 'package:flutter/material.dart';
import 'package:wechat_post/features/postedit/screens/post_edit_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case PostEditScrren.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PostEditScrren(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
