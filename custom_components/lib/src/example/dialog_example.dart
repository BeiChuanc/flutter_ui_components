/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 * 
 * 对话框组件示例
 * 展示 BehaviorDialogBox、GlobalTooltip、ReportDialog、UpdateUserDialog 的使用方法
 */

import 'package:custom_components/src/config_export.dart';

/// 对话框组件示例页面
/// Dialog Components Example Page
class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog Examples'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Behavior Dialog Box'),
            SizedBox(height: 12.h),
            _buildBehaviorDialogExample(context),
            SizedBox(height: 32.h),
            _buildSectionTitle('Global Tooltip'),
            SizedBox(height: 12.h),
            _buildGlobalTooltipExample(context),
            SizedBox(height: 32.h),
            _buildSectionTitle('Report Dialog'),
            SizedBox(height: 12.h),
            _buildReportDialogExample(context),
            SizedBox(height: 32.h),
            _buildSectionTitle('Update User Dialog'),
            SizedBox(height: 12.h),
            _buildUpdateUserDialogExample(context),
          ],
        ),
      ),
    );
  }

  /// 构建章节标题
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  /// 行为对话框示例
  /// Behavior Dialog Box Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 删除确认对话框
  /// BehaviorDialogBox.delete(
  ///   context,
  ///   content: 'Are you sure you want to delete this item?',
  ///   onConfirm: () {
  ///     // 执行删除逻辑
  ///   },
  /// );
  /// 
  /// // 登出确认对话框
  /// BehaviorDialogBox.logout(
  ///   context,
  ///   content: 'Are you sure you want to logout?',
  ///   onConfirm: () {
  ///     // 执行登出逻辑
  ///   },
  /// );
  /// 
  /// // 自定义类型对话框
  /// BehaviorDialogBox.show(
  ///   context,
  ///   type: BehaviorDialogBoxType.delete,
  ///   content: 'Custom content here',
  ///   buttonText: 'Confirm',
  ///   onConfirm: () {
  ///     // 执行确认逻辑
  ///   },
  /// );
  /// ```
  Widget _buildBehaviorDialogExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirmation dialogs for delete and logout actions.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            // 删除对话框按钮
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  BehaviorDialogBox.delete(
                    context,
                    content: 'Are you sure you want to delete this item?',
                    onConfirm: () {
                      GlobalTooltip.show('Item deleted!');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Delete Dialog'),
              ),
            ),
            SizedBox(width: 12.w),
            // 登出对话框按钮
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  BehaviorDialogBox.logout(
                    context,
                    content: 'Are you sure you want to logout?',
                    onConfirm: () {
                      GlobalTooltip.show('Logged out!');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logout Dialog'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 全局提示框示例
  /// Global Tooltip Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 基础提示
  /// GlobalTooltip.show('This is a message');
  /// 
  /// // 成功提示（绿色背景）
  /// GlobalTooltip.success('Operation successful!');
  /// 
  /// // 错误提示（红色背景）
  /// GlobalTooltip.error('Something went wrong!');
  /// 
  /// // 警告提示（橙色背景）
  /// GlobalTooltip.warning('Please check your input!');
  /// 
  /// // 信息提示（蓝色背景）
  /// GlobalTooltip.info('New version available!');
  /// 
  /// // 自定义样式提示
  /// GlobalTooltip.show(
  ///   'Custom styled message',
  ///   duration: Duration(seconds: 2),
  ///   backgroundColor: Colors.purple,
  ///   textColor: Colors.white,
  ///   fontSize: 16.sp,
  ///   borderRadius: 25.r,
  /// );
  /// ```
  Widget _buildGlobalTooltipExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Various toast-style notifications.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            // 基础提示
            ElevatedButton(
              onPressed: () => GlobalTooltip.show('This is a message'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('Basic', style: TextStyle(color: Colors.white)),
            ),
            // 成功提示
            ElevatedButton(
              onPressed: () => GlobalTooltip.success('Operation successful!'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Success', style: TextStyle(color: Colors.white)),
            ),
            // 错误提示
            ElevatedButton(
              onPressed: () => GlobalTooltip.error('Something went wrong!'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Error', style: TextStyle(color: Colors.white)),
            ),
            // 警告提示
            ElevatedButton(
              onPressed: () => GlobalTooltip.warning('Please check your input!'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Warning', style: TextStyle(color: Colors.white)),
            ),
            // 信息提示
            ElevatedButton(
              onPressed: () => GlobalTooltip.info('New version available!'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Info', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }

  /// 举报对话框示例
  /// Report Dialog Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 显示举报帖子对话框（底部弹窗形式）
  /// ReportDialog.reportPost(
  ///   context,
  ///   onOptionSelected: (option) {
  ///     switch (option) {
  ///       case ReportOption.sexuallyExplicit:
  ///         // 处理色情内容举报
  ///         break;
  ///       case ReportOption.spam:
  ///         // 处理垃圾信息举报
  ///         break;
  ///       case ReportOption.other:
  ///         // 处理其他举报
  ///         break;
  ///       case ReportOption.reportOrBlock:
  ///         // 处理举报或屏蔽
  ///         break;
  ///     }
  ///   },
  /// );
  /// 
  /// // 显示举报用户对话框
  /// ReportDialog.reportUser(
  ///   context,
  ///   onOptionSelected: (option) {
  ///     // 处理选项
  ///   },
  /// );
  /// 
  /// // 以对话框形式显示
  /// ReportDialog.show(
  ///   context,
  ///   type: ReportType.post,
  ///   onOptionSelected: (option) {
  ///     // 处理选项
  ///   },
  /// );
  /// ```
  Widget _buildReportDialogExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Report options for posts and users.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            // 举报帖子
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ReportDialog.reportPost(
                    context,
                    onOptionSelected: (option) {
                      GlobalTooltip.show('Selected: ${option.text.isNotEmpty ? option.text : "Report"}');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Report Post'),
              ),
            ),
            SizedBox(width: 12.w),
            // 举报用户
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ReportDialog.reportUser(
                    context,
                    onOptionSelected: (option) {
                      GlobalTooltip.show('Selected: ${option.text.isNotEmpty ? option.text : "Block"}');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Report User'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 用户信息更新对话框示例
  /// Update User Dialog Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 更新用户名
  /// UpdateUserDialog.updateName(
  ///   context,
  ///   currentName: 'John Doe',
  ///   onConfirm: (newName) {
  ///     // 处理新用户名
  ///     print('New name: $newName');
  ///   },
  /// );
  /// 
  /// // 更新用户简介
  /// UpdateUserDialog.updateIntro(
  ///   context,
  ///   currentIntro: 'Hello, I am John',
  ///   onConfirm: (newIntro) {
  ///     // 处理新简介
  ///     print('New intro: $newIntro');
  ///   },
  /// );
  /// 
  /// // 自定义对话框
  /// UpdateUserDialog.show(
  ///   context,
  ///   type: UpdateInfoType.name,
  ///   currentValue: 'Current Value',
  ///   onConfirm: (value) {
  ///     // 处理新值
  ///   },
  ///   title: 'Custom Title',
  ///   maxLength: 30,
  /// );
  /// ```
  Widget _buildUpdateUserDialogExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dialogs for updating user name and intro.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            // 更新用户名
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  UpdateUserDialog.updateName(
                    context,
                    currentName: 'John Doe',
                    onConfirm: (newName) {
                      GlobalTooltip.success('Name updated to: $newName');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Update Name'),
              ),
            ),
            SizedBox(width: 12.w),
            // 更新用户简介
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  UpdateUserDialog.updateIntro(
                    context,
                    currentIntro: 'Hello, I am John',
                    onConfirm: (newIntro) {
                      GlobalTooltip.success('Intro updated!');
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Update Intro'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

