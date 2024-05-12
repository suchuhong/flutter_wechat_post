import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/features/postedit/widgets/normal_photo_item.dart';
import 'package:wechat_post/providers/drag_photo_provider.dart';

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
          // isDragNow = true;
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsDragNow(true); // 更新全局变量的值
        });
      },

      // 当可拖动对象被放下时调用。
      onDragEnd: (DraggableDetails details) {
        setState(() {
          // isDragNow = false;
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsDragNow(false); // 更新全局变量的值
        });
      },

      // 当 draggable 被放置并被 [DragTarget] 接受时调用。
      onDragCompleted: () {},

      // 当 draggable 被放置但未被 [DragTarget] 接受时调用。
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        setState(() {
          // isDragNow = false;
          Provider.of<DragPhotoProvider>(context, listen: false)
              .updateIsDragNow(false); // 更新全局变量的值
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

      child: GestureDetector(
        onTap: widget.onTap,
        child: NormalPhotoItem(
          asset: widget.asset,
          width: widget.width,
        ),
      ),
    );
  }
}
