import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/features/postedit/widgets/gallery_bar.dart';
import 'package:wechat_post/features/postedit/widgets/image_view.dart';

class Gallery extends StatefulWidget {
  // 初始图片位置
  final int initialIndex;
  // 图片列表
  final List<AssetEntity> items;
  // 是否显示 bar
  final bool? isBarVisible;

  const Gallery({
    super.key,
    required this.initialIndex,
    required this.items,
    this.isBarVisible,
  });

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with SingleTickerProviderStateMixin {
  bool visible = true;

  // 动画控制器
  late final AnimationController controller;

  void setVisible() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  void initState() {
    super.initState();
    visible = widget.isBarVisible ?? true;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: setVisible,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: GalleryBar(
          controller: controller,
          visible: visible,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        body: ImageView(
          initialIndex: widget.initialIndex,
          items: widget.items,
        ),
      ),
    );
  }
}
