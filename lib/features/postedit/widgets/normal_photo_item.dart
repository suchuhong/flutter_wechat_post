import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/providers/drag_photo_provider.dart';
import 'package:wechat_post/utils/config.dart';

class NormalPhotoItem extends StatelessWidget {
  final AssetEntity asset;
  final double width;
  const NormalPhotoItem({
    super.key,
    required this.asset,
    required this.width,
  });

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
