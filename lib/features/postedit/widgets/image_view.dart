import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageView extends StatelessWidget {
  // 初始图片位置
  final int initialIndex;
  // 图片列表
  final List<AssetEntity> items;
  const ImageView({
    super.key,
    required this.initialIndex,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImageGesturePageView.builder(
      controller: ExtendedPageController(
        initialPage: initialIndex,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final AssetEntity item = items[index];
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
