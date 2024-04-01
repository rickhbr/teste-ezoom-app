import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin ScreenUtilityMixin {
  double setWidth(num width) {
    return ScreenUtil().setWidth(width);
  }

  double setHeight(num height) {
    return ScreenUtil().setHeight(height);
  }

  double setRadius(num radius) {
    return ScreenUtil().radius(radius);
  }

  double setFontSize(num fontSize) {
    return ScreenUtil().setSp(fontSize);
  }

  Size setProperSize({required double width, required double height}) {
    final aspectRatio = width / height;
    return Size(setWidth(width), setWidth(width) / aspectRatio);
  }
}
