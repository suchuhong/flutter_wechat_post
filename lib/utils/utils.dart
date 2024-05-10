import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_post/utils/config.dart';

Future<List<AssetEntity>> pickImages(BuildContext context) async {
  List<AssetEntity> selectedAssets = [];
  try {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets: selectedAssets,
        maxAssets: maxAssets,
      ),
    );
    if (result != null) {
      selectedAssets = result;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return selectedAssets;
}
