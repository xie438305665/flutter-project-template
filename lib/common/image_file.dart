import 'dart:io';

import 'package:flutter/material.dart';

/// @description:解决 文件名称.路径不变，文件内容变化时，Flutter并不会更新显示
/// @author xcl qq:244672784
/// @Date 2020/5/10 17:27
class ImageFile extends FileImage {
  int fileSize;

  ImageFile(File file, {double scale = 1.0})
      : assert(file != null),
        assert(scale != null),
        super(file, scale: scale) {
    fileSize = file.lengthSync();
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final ImageFile typedOther = other;
    return file?.path == typedOther.file?.path &&
        scale == typedOther.scale &&
        fileSize == typedOther.fileSize;
  }
}
