import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/features/postedit/widgets/normal_photo_item.dart';

class GesturePhotoItem extends StatelessWidget {
  final AssetEntity asset;
  final double width;
  final VoidCallback onTap;
  const GesturePhotoItem({
    super.key,
    required this.asset,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NormalPhotoItem(
        asset: asset,
        width: width,
      ),
    );
  }
}
