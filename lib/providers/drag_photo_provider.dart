import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/models/drag_photo.dart';

class DragPhotoProvider extends ChangeNotifier {
  DragPhoto _dragPhoto = DragPhoto(
    false,
    false,
    [],
    false,
    "",
  );

  void updateDragPhoto(DragPhoto dragPhoto) {
    _dragPhoto = dragPhoto;
    notifyListeners();
  }

  void updateIsDragNow(bool isDragNow) {
    _dragPhoto.isDragNow = isDragNow;
    notifyListeners();
  }

  void updateIsWillRemove(bool isWillRemove) {
    _dragPhoto.isWillRemove = isWillRemove;
    notifyListeners();
  }

  void updateIsWillOrder(bool isWillOrder) {
    _dragPhoto.isWillOrder = isWillOrder;
    notifyListeners();
  }

  void updateTargetAssetId(String targetAssetId) {
    _dragPhoto.targetAssetId = targetAssetId;
    notifyListeners();
  }

  bool getIsWillRemove() {
    return _dragPhoto.isWillRemove;
  }

  bool getIsDragNow() {
    return _dragPhoto.isDragNow;
  }

  bool getIsWillOrder() {
    return _dragPhoto.isWillOrder;
  }

  String getTargetAssetId() {
    return _dragPhoto.targetAssetId;
  }

  void removeSelectedAsset(AssetEntity assetEntity) {
    _dragPhoto.selectedAssets.remove(assetEntity);
    notifyListeners();
  }

  void removeSelectedAssetById(int id) {
    _dragPhoto.selectedAssets.removeAt(id);
    notifyListeners();
  }

  void insertBeforeSelectedAsset(int id, AssetEntity assetEntity) {
    _dragPhoto.selectedAssets.insert(id, assetEntity);
    notifyListeners();
  }

  void updateSelectedAsset(int index) {
    _dragPhoto.selectedAssets.removeAt(index);
    notifyListeners();
  }

  List<AssetEntity> getSelectedAsset() {
    return _dragPhoto.selectedAssets;
  }
}
