import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class DragPhoto {
  final List<AssetEntity> _selectedAssets;
  // 是否开始拖拽
  bool _isDragNow;
  // 是否将要删除
  bool _isWillRemove;

  DragPhoto(
    this._isDragNow,
    this._isWillRemove,
    this._selectedAssets,
  );

  bool get isDragNow => _isDragNow;

  set isDragNow(bool isDragNow) => _isDragNow = isDragNow;

  bool get isWillRemove => _isWillRemove;

  set isWillRemove(bool isWillRemove) => _isWillRemove = isWillRemove;

  List<AssetEntity> get selectedAssets => _selectedAssets;

  set selectedAssets(List<AssetEntity> selectedAssets) =>
      selectedAssets = _selectedAssets;
}
