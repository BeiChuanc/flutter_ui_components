/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:beichuan_ui_components/src/config_export.dart';

/// 全局提示框工具类
class GlobalTooltip {
  /// 显示全局提示框
  /// [message]  - 提示内容
  /// [duration] - 显示时长
  static void show(
    String message, {
    Duration duration = const Duration(milliseconds: 1200),
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    double? borderRadius,
    double? horizontalPadding,
    double? verticalPadding,
    double? maxWidth,
  }) {
    BotToast.showCustomText(
      toastBuilder: (cancel) => _GlobalTooltipWidget(
        message: message,
        backgroundColor: backgroundColor ?? HexColor.fromHex('#FFFFFF'),
        textColor: textColor ?? HexColor.fromHex('#000000'),
        fontSize: fontSize ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        borderRadius: borderRadius ?? 20.r,
        horizontalPadding: horizontalPadding ?? 16.w,
        verticalPadding: verticalPadding ?? 12.h,
        maxWidth: maxWidth ?? 32.w,
      ),
      duration: duration,
    );
  }

  /// 显示成功提示
  static void success(
    String message, {
    Duration duration = const Duration(milliseconds: 1200),
  }) => show(
    message,
    duration: duration,
    backgroundColor: HexColor.fromHex('#4CAF50'),
    textColor: Colors.white,
  );

  /// 显示错误提示
  static void error(
    String message, {
    Duration duration = const Duration(milliseconds: 1200),
  }) => show(
    message,
    duration: duration,
    backgroundColor: HexColor.fromHex('#F44336'),
    textColor: Colors.white,
  );

  /// 显示警告提示
  static void warning(
    String message, {
    Duration duration = const Duration(milliseconds: 1200),
  }) => show(
    message,
    duration: duration,
    backgroundColor: HexColor.fromHex('#FF9800'),
    textColor: Colors.white,
  );

  /// 显示信息提示
  static void info(
    String message, {
    Duration duration = const Duration(milliseconds: 1200),
  }) => show(
    message,
    duration: duration,
    backgroundColor: HexColor.fromHex('#2196F3'),
    textColor: Colors.white,
  );
}

/// 全局提示框内部组件, 私有组件不对外暴露
class _GlobalTooltipWidget extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final double maxWidth;

  const _GlobalTooltipWidget({
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight,
    required this.borderRadius,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - maxWidth,
          ),
          child: IntrinsicWidth(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
