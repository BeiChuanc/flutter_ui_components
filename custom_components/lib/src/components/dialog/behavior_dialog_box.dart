/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:beichuan_ui_components/src/config_export.dart';

/// 行为对话框类型
enum BehaviorDialogBoxType { delete, logout }

/// 行为对话框工具类
class BehaviorDialogBox {
  /// 显示行为对话框
  /// [context]  - 上下文
  /// [type]     - 对话框类型
  /// [content]  - 内容文本
  /// [buttonText] - 确认按钮文本
  /// [onConfirm] - 确认回调
  static Future<void> show(
    BuildContext context, {
    required BehaviorDialogBoxType type,
    required String content,
    required String buttonText,
    VoidCallback? onConfirm,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _BehaviorDialogBoxWidget(
        type: type,
        content: content,
        buttonText: buttonText,
        onConfirm: onConfirm,
      ),
    );
  }

  /// 显示删除确认对话框
  static Future<void> delete(
    BuildContext context, {
    required String content,
    VoidCallback? onConfirm,
  }) => show(
    context,
    type: BehaviorDialogBoxType.delete,
    content: content,
    buttonText: 'Delete',
    onConfirm: onConfirm,
  );

  /// 显示登出确认对话框
  static Future<void> logout(
    BuildContext context, {
    required String content,
    VoidCallback? onConfirm,
  }) => show(
    context,
    type: BehaviorDialogBoxType.logout,
    content: content,
    buttonText: 'Logout',
    onConfirm: onConfirm,
  );
}

/// 行为对话框内部组件, 私有组件不对外暴露
class _BehaviorDialogBoxWidget extends StatelessWidget {
  final BehaviorDialogBoxType type;
  final String content;
  final String buttonText;
  final VoidCallback? onConfirm;

  const _BehaviorDialogBoxWidget({
    required this.type,
    required this.content,
    required this.buttonText,
    this.onConfirm,
  });

  String get _title =>
      type == BehaviorDialogBoxType.delete ? 'Delete' : 'Logout';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle(double size, FontWeight weight, Color color) =>
        TextStyle(color: color, fontSize: size, fontWeight: weight);

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        _title,
        textAlign: TextAlign.center,
        style: textStyle(18.sp, FontWeight.w600, HexColor.fromHex('#000000')),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: textStyle(14.sp, FontWeight.w400, HexColor.fromHex('#000000')),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 65.w,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: textStyle(
                  16.sp,
                  FontWeight.w500,
                  HexColor.fromHex('#000000'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text(
                buttonText,
                style: textStyle(
                  16.sp,
                  FontWeight.w600,
                  HexColor.fromHex('#000000'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
