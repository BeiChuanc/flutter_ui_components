/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lume_ui/src/config_export.dart';

/// 高斯模糊背景组件 - 提供毛玻璃效果
/// [child]          - 子组件
/// [radius]         - 圆角
/// [height]         - 高度
/// [width]          - 宽度
/// [maxWidth]       - 最大宽度
/// [paddingH]       - 水平内边距
/// [paddingV]       - 垂直内边距
/// [margin]         - 外边距
/// [hasBorder]      - 是否需要边框
/// [hasShadow]      - 是否需要阴影
/// [hasTilt]        - 是否需要倾斜
/// [gradientColors] - 渐变颜色
/// [blurSigma]      - 模糊程度
class GaussianBlur extends StatelessWidget {
  final Widget child;
  final double radius;
  final double? height;
  final double? width;
  final double? maxWidth;
  final double paddingH;
  final double paddingV;
  final double margin;
  final bool hasBorder;
  final bool hasShadow;
  final bool hasTilt;
  final List<Color>? gradientColors;
  final double blurSigma;

  const GaussianBlur({
    super.key,
    required this.child,
    this.radius = 12.0,
    this.height,
    this.width,
    this.maxWidth,
    this.paddingH = 12.0,
    this.paddingV = 12.0,
    this.margin = 0.0,
    this.hasBorder = true,
    this.hasShadow = false,
    this.hasTilt = false,
    this.gradientColors,
    this.blurSigma = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      height: height,
      width: width,
      constraints: maxWidth != null
          ? BoxConstraints(maxWidth: maxWidth!)
          : null,
      margin: EdgeInsets.symmetric(horizontal: margin),
      padding: EdgeInsets.symmetric(
        horizontal: paddingH.w,
        vertical: paddingV.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
              gradientColors ??
              [HexColor.fromHex("#000000"), HexColor.fromHex("#000000", opacity: 0.5)],
        ),
        borderRadius: BorderRadius.circular(radius.r),
        border: hasBorder
            ? Border.all(
                color: HexColor.fromHex("#FFFFFF", opacity: 0.45),
                width: 1.5.w,
              )
            : null,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: HexColor.fromHex("#002FFF", opacity: 0.35),
                  blurRadius: 1.2.w,
                  offset: Offset(0, 1.2.w),
                ),
              ]
            : null,
      ),
      child: child,
    );

    Widget blurred = ClipRRect(
      borderRadius: BorderRadius.circular(radius.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: container,
      ),
    );

    return hasTilt
        ? Transform(
            transform: Matrix4.skewX(-0.2),
            alignment: Alignment.center,
            child: blurred,
          )
        : blurred;
  }
}
