import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/features/postedit/widgets/gallery_bar.dart';

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
    // setState(() {
    //   visible = !visible;
    // });
    () => Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }

  Widget _mainView() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: setVisible,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        // appBar: GalleryBar(
        //   controller: controller,
        //   visible: visible,
        //   child: AppBar(
        //     backgroundColor: Colors.transparent,
        //     elevation: 0,
        //   ),
        // ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: _buildImageView(),
      ),
    );
  }

  Widget _buildImageView() {
    return ExtendedImageGesturePageView.builder(
      controller: ExtendedPageController(
        initialPage: widget.initialIndex,
      ),
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        final AssetEntity item = widget.items[index];
        return ExtendedImage(
          image: AssetEntityImageProvider(
            item,
            isOriginal: true,
          ),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: ((state) {
            return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: true, // 是否使用 ExtendedImageGesturePageView 展示图片
            );
          }),
        );
      },
    );
  }
}
