import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/features/postedit/widgets/normal_photo_item.dart';
import 'package:wechat_post/providers/drag_photo_provider.dart';
import 'package:wechat_post/utils/config.dart';

class DraggablePhotoItem extends StatefulWidget {
  final AssetEntity asset;
  final double width;
  final VoidCallback onTap;

  const DraggablePhotoItem({
    super.key,
    required this.asset,
    required this.width,
    required this.onTap,
  });

  @override
  State<DraggablePhotoItem> createState() => _DraggablePhotoItemState();
}

class _DraggablePhotoItemState extends State<DraggablePhotoItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      // 此可拖动对象将拖放的数据。
      data: widget.asset,

      // 当可拖动对象开始被拖动时调用。
      onDragStarted: () {
        setState(() {
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsDragNow(true); // 更新全局变量的值
        });
      },

      // 当可拖动对象被放下时调用。
      onDragEnd: (DraggableDetails details) {
        setState(() {
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsDragNow(false); // 更新全局变量的值
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsWillOrder(false); // 更新全局变量的值
        });
      },

      // 当 draggable 被放置并被 [DragTarget] 接受时调用。
      onDragCompleted: () {},

      // 当 draggable 被放置但未被 [DragTarget] 接受时调用。
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        setState(() {
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsDragNow(false); // 更新全局变量的值
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsWillOrder(false); // 更新全局变量的值
        });
      },

      // 拖动进行时显示在指针下方的小部件。
      feedback: NormalPhotoItem(
        asset: widget.asset,
        width: widget.width,
      ),

      // 当正在进行一个或多个拖动时显示的小部件而不是 [child]。
      childWhenDragging: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        child: AssetEntityImage(
          widget.asset,
          width: widget.width,
          height: widget.width,
          fit: BoxFit.cover,
          isOriginal: false,
          opacity: const AlwaysStoppedAnimation(0.2),
        ),
      ),
      child: DragTarget<AssetEntity>(
        builder: (context, candidateData, rejectedData) {
          return GestureDetector(
            onTap: widget.onTap,
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding:
                  (Provider.of<DragPhotoProvider>(context).getIsWillOrder() &&
                          Provider.of<DragPhotoProvider>(context)
                                  .getTargetAssetId() ==
                              widget.asset.id)
                      ? EdgeInsets.zero
                      : const EdgeInsets.all(imagePadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border:
                    (Provider.of<DragPhotoProvider>(context).getIsWillOrder() &&
                            Provider.of<DragPhotoProvider>(context)
                                    .getTargetAssetId() ==
                                widget.asset.id)
                        ? Border.all(
                            color: accentColor,
                            width: imagePadding,
                          )
                        : null,
              ),
              child: AssetEntityImage(
                widget.asset,
                width: widget.width,
                height: widget.width,
                fit: BoxFit.cover,
                isOriginal: false,
              ),
            ),
          );
        },

        // 调用以确定此小部件是否有兴趣接收给定的 被拖动到这个拖动目标上的数据片段。
        onWillAcceptWithDetails: (data) {
          // 排除自己
          if (data.data.id == widget.asset.id) {
            return false;
          }
          setState(() {
            Provider.of<DragPhotoProvider>(context, listen: false)
                .updateIsWillRemove(true); // 更新全局变量的值
            Provider.of<DragPhotoProvider>(context, listen: false)
                .updateTargetAssetId(widget.asset.id); // 更新全局变量的值
          });
          return true;
        },

        // 当一条可接受的数据被拖放到这个拖动目标上时调用。
        // onWillAcceptWithDetails 返回 true 调用这里
        onAcceptWithDetails: (data) {
          // 0 当前元素位置
          int curIndex = Provider.of<DragPhotoProvider>(context, listen: false)
              .getSelectedAsset()
              .indexOf(data.data);
          // 1 拖到的位置targetIndex
          int targetIndex =
              Provider.of<DragPhotoProvider>(context, listen: false)
                  .getSelectedAsset()
                  .indexOf(widget.asset);

          // 2 删除原来的
          Provider.of<DragPhotoProvider>(context, listen: false)
              .removeSelectedAssetById(curIndex);

          // 3 插入到目标前面
          Provider.of<DragPhotoProvider>(context, listen: false)
              .insertBeforeSelectedAsset(targetIndex, data.data);

          setState(() {
            Provider.of<DragPhotoProvider>(context, listen: false)
                .updateIsWillRemove(false);
            Provider.of<DragPhotoProvider>(context, listen: false)
                .updateIsWillOrder(false);
            Provider.of<DragPhotoProvider>(context, listen: false)
                .updateTargetAssetId("");
          });
        },

        // 当被拖动到该目标上的给定数据离开时调用 目标。
        onLeave: (data) {
          setState(() {
            Provider.of<DragPhotoProvider>(context, listen: false)
                .updateIsWillRemove(false);
            Provider.of<DragPhotoProvider>(context, listen: false)
                .updateIsWillOrder(false);
            Provider.of<DragPhotoProvider>(context, listen: false)
                .updateTargetAssetId("");
          });
        },
      ),
    );
  }
}
