/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:flutter/material.dart';
import 'package:lume_ui/src/config_export.dart';

/// 举报类型枚举
enum ReportType { post, user }

/// 举报选项枚举
enum ReportOption {
  sexuallyExplicit('Report Sexually Explicit Material'),
  spam('Report spam'),
  other('Report something else'),
  reportOrBlock('');

  final String text;
  const ReportOption(this.text);
}

/// 举报对话框工具类
class ReportDialog {
  /// 显示对话框形式
  static Future<void> show(
    BuildContext context, {
    required ReportType type,
    required Function(ReportOption) onOptionSelected,
  }) => showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) =>
        _ReportDialogWidget(type: type, onOptionSelected: onOptionSelected),
  );

  /// 显示底部弹窗形式
  static Future<void> showAsBottomSheet(
    BuildContext context, {
    required ReportType type,
    required Function(ReportOption) onOptionSelected,
  }) => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) =>
        _ReportDialogWidget(type: type, onOptionSelected: onOptionSelected),
  );

  /// 快捷方法：举报帖子
  static Future<void> reportPost(
    BuildContext context, {
    required Function(ReportOption) onOptionSelected,
  }) => showAsBottomSheet(
    context,
    type: ReportType.post,
    onOptionSelected: onOptionSelected,
  );

  /// 快捷方法：举报用户
  static Future<void> reportUser(
    BuildContext context, {
    required Function(ReportOption) onOptionSelected,
  }) => showAsBottomSheet(
    context,
    type: ReportType.user,
    onOptionSelected: onOptionSelected,
  );
}

/// 举报对话框内部组件, 私有组件不对外暴露
class _ReportDialogWidget extends StatelessWidget {
  final ReportType type;
  final Function(ReportOption) onOptionSelected;

  const _ReportDialogWidget({
    required this.type,
    required this.onOptionSelected,
  });

  Widget _option(BuildContext ctx, ReportOption opt) {
    final txt = opt == ReportOption.reportOrBlock
        ? (type == ReportType.post ? 'Report' : 'Block')
        : opt.text;
    return SizedBox(
      height: 44.h,
      child: InkWell(
        onTap: () {
          Navigator.pop(ctx);
          onOptionSelected(opt);
        },
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
              fontSize: 15.sp,
              color: HexColor.fromHex('#333333'),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final optStyle = TextStyle(
      fontSize: 15.sp,
      color: HexColor.fromHex('#333333'),
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(child: InkWell(onTap: () => Navigator.pop(context))),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              spacing: 6.h,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'More',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _option(context, ReportOption.sexuallyExplicit),
                _option(context, ReportOption.spam),
                _option(context, ReportOption.other),
                _option(context, ReportOption.reportOrBlock),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 50.h,
            width: MediaQuery.of(context).size.width - 32.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Center(child: Text('Cancel', style: optStyle)),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}


