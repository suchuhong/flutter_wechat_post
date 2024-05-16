import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/providers/drag_photo_provider.dart';

class RemoveBar extends StatefulWidget {
  const RemoveBar({super.key});

  @override
  State<RemoveBar> createState() => _RemoveBarState();
}

class _RemoveBarState extends State<RemoveBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<AssetEntity>(
      // 调用以构建此小部件的内容。
      builder: (context, candidateData, rejectedData) {
        return SizedBox(
          width: double.infinity,
          child: Container(
            color: Provider.of<DragPhotoProvider>(context).getIsWillRemove()
                ? Colors.red[300]
                : Colors.red[200],
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 图标
                Icon(
                  Icons.delete,
                  color:
                      Provider.of<DragPhotoProvider>(context).getIsWillRemove()
                          ? Colors.white
                          : Colors.white70,
                  size: 32,
                ),
                // 文字
                Text(
                  "拖拽到这里删除",
                  style: TextStyle(
                    color: Provider.of<DragPhotoProvider>(context)
                            .getIsWillRemove()
                        ? Colors.white
                        : Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        );
      },

      // 调用以确定此小部件是否有兴趣接收给定的 被拖动到这个拖动目标上的数据片段。
      onWillAcceptWithDetails: (data) {
        setState(() {
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsWillRemove(true); // 更新全局变量的值
        });
        return true;
      },

      // 当一条可接受的数据被拖放到这个拖动目标上时调用。
      // onWillAcceptWithDetails 返回 true 调用这里
      onAcceptWithDetails: (data) {
        setState(() {
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsWillRemove(false);
          Provider.of<DragPhotoProvider>(context, listen: false)
              .removeSelectedAsset(data.data);
        });
      },

      // 当被拖动到该目标上的给定数据离开时调用 目标。
      onLeave: (data) {
        setState(() {
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsWillRemove(false);
        });
      },
    );
  }
}
