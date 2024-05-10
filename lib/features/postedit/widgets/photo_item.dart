import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PhotoItem extends StatelessWidget {
  final AssetEntity asset;
  final double width;
  const PhotoItem({super.key, required this.asset, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
      ),
      child: AssetEntityImage(
        asset,
        width: width,
        height: width,
        fit: BoxFit.cover,
        isOriginal: false,
      ),
    );
  }
}
