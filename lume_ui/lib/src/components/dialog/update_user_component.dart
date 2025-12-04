/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:flutter/material.dart';
import 'package:lume_ui/src/config_export.dart';

/// 用户信息更新类型枚举
enum UpdateInfoType { name, intro }

/// 用户信息更新对话框工具类
class UpdateUserDialog {
  /// 显示用户信息更新对话框
  /// [context]      - 上下文
  /// [type]         - 更新类型
  /// [currentValue] - 当前值
  /// [onConfirm]    - 确认回调
  /// [title]        - 标题（可选）
  /// [maxLength]    - 最大长度
  static Future<void> show(
    BuildContext context, {
    required UpdateInfoType type,
    required String currentValue,
    required Function(String) onConfirm,
    String? title,
    int maxLength = 20,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => _UpdateUserDialogWidget(
        type: type,
        currentValue: currentValue,
        onConfirm: onConfirm,
        title:
            title ??
            (type == UpdateInfoType.name ? 'Update Name' : 'Update Intro'),
        maxLength: maxLength,
      ),
    );
  }

  /// 快捷方法：更新用户名
  static Future<void> updateName(
    BuildContext context, {
    required String currentName,
    required Function(String) onConfirm,
  }) => show(
    context,
    type: UpdateInfoType.name,
    currentValue: currentName,
    onConfirm: onConfirm,
  );

  /// 快捷方法：更新用户简介
  static Future<void> updateIntro(
    BuildContext context, {
    required String currentIntro,
    required Function(String) onConfirm,
  }) => show(
    context,
    type: UpdateInfoType.intro,
    currentValue: currentIntro,
    onConfirm: onConfirm,
  );
}

/// 用户信息更新对话框内部组件, 私有组件不对外暴露
class _UpdateUserDialogWidget extends StatefulWidget {
  final UpdateInfoType type;
  final String currentValue;
  final Function(String) onConfirm;
  final String title;
  final int maxLength;

  const _UpdateUserDialogWidget({
    required this.type,
    required this.currentValue,
    required this.onConfirm,
    required this.title,
    required this.maxLength,
  });

  @override
  State<_UpdateUserDialogWidget> createState() =>
      _UpdateUserDialogWidgetState();
}

class _UpdateUserDialogWidgetState extends State<_UpdateUserDialogWidget> {
  late TextEditingController _controller;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _confirm() {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      GlobalTooltip.show(
        widget.type == UpdateInfoType.name
            ? 'Name cannot be empty'
            : 'Intro cannot be empty',
      );
      return;
    }
    Navigator.pop(context);
    if (value != widget.currentValue) widget.onConfirm(value);
  }

  Widget _button(String text, VoidCallback onTap, {bool primary = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: HexColor.fromHex('#1C1C1C', opacity: 0.15),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: primary ? FontWeight.w600 : FontWeight.w500,
            color: HexColor.fromHex('#1C1C1C'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: HexColor.fromHex('#FFFFFF'),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: HexColor.fromHex('#1C1C1C'),
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: HexColor.fromHex('#1C1C1C', opacity: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: HexColor.fromHex('#1C1C1C'),
                ),
                decoration: InputDecoration(
                  hintText:
                      'Enter your info',
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: HexColor.fromHex('#1C1C1C'),
                  ),
                  counterStyle: TextStyle(
                    fontSize: 12.sp,
                    color: HexColor.fromHex('#1C1C1C'),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                maxLength: widget.maxLength,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _confirm(),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 12.w,
                children: [
                  _button('Cancel', () => Navigator.pop(context)),
                  _button('Confirm', _confirm, primary: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
