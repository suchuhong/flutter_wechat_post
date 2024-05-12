import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/features/postedit/widgets/add_button.dart';
import 'package:wechat_post/features/postedit/widgets/gallery.dart';
import 'package:wechat_post/features/postedit/widgets/photo_item.dart';
import 'package:wechat_post/utils/config.dart';
import 'package:wechat_post/utils/utils.dart';

class PostEditScrren extends StatefulWidget {
  static const String routeName = '/post-edit';
  const PostEditScrren({super.key});

  @override
  State<PostEditScrren> createState() => _PostEditScrrenState();
}

class _PostEditScrrenState extends State<PostEditScrren> {
  List<AssetEntity> selectedAssets = [];

  void selectImages() async {
    var res = await pickImages(context);
    setState(() {
      selectedAssets = res;
    });
  }

  void gallery(AssetEntity curAssetEntity) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Gallery(
          initialIndex: selectedAssets.indexOf(curAssetEntity),
          items: selectedAssets,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("发布"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(spacing),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double width = (constraints.maxWidth - spacing * 2) / 3;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                // 图片
                for (final asset in selectedAssets)
                  PhotoItem(
                    onTap: () {
                      gallery(asset);
                    },
                    asset: asset,
                    width: width,
                  ),

                // 选着图片按钮
                if (selectedAssets.length < maxAssets)
                  AddButton(
                    onTap: () {
                      selectImages();
                    },
                    width: width,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
