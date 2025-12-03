/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 * 
 * 按钮组件示例
 * 展示 AppleLogin、GlobalBackButton、ReportButton 的使用方法
 */

import 'package:custom_components/src/config_export.dart';

/// 按钮组件示例页面
/// Button Components Example Page
class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Examples'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Apple Login Button'),
            SizedBox(height: 12.h),
            _buildAppleLoginExample(context),
            SizedBox(height: 32.h),
            _buildSectionTitle('Global Back Button'),
            SizedBox(height: 12.h),
            _buildBackButtonExample(context),
            SizedBox(height: 32.h),
            _buildSectionTitle('Report Button'),
            SizedBox(height: 12.h),
            _buildReportButtonExample(context),
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

  /// Apple 登录按钮示例
  /// Apple Login Button Example
  /// 
  /// 使用方法:
  /// ```dart
  /// AppleLogin(
  ///   image: 'assets/icons/apple_logo.png',
  ///   appleLoginCallback: () {
  ///     // 处理苹果登录逻辑
  ///   },
  /// )
  /// ```
  Widget _buildAppleLoginExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Standard Apple login button with icon and text.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        // 示例：苹果登录按钮
        AppleLogin(
          image: 'assets/icons/apple_logo.png', // 替换为你的苹果图标路径
          appleLoginCallback: () {
            GlobalTooltip.show('Apple Login Clicked!');
          },
        ),
      ],
    );
  }

  /// 返回按钮示例
  /// Back Button Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 基础用法 - 默认配置（带模糊效果）
  /// GlobalBackButton()
  /// 
  /// // 自定义配置
  /// GlobalBackButton(
  ///   config: BackButtonConfig(
  ///     size: 30.0,
  ///     hasBlur: true,
  ///     backIcon: true,
  ///     image: 'assets/icons/back.png',
  ///   ),
  ///   onTap: () => Navigator.pop(context),
  /// )
  /// 
  /// // 无模糊效果的配置
  /// GlobalBackButton(
  ///   config: BackButtonConfig.noBlur(size: 25.0),
  /// )
  /// ```
  Widget _buildBackButtonExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Back button with optional blur effect.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 示例1：带模糊效果的返回按钮
              Column(
                children: [
                  GlobalBackButton(
                    config: BackButtonConfig(
                      size: 25.0,
                      hasBlur: true,
                      image: 'assets/icons/back.png', // 替换为你的返回图标路径
                    ),
                    onTap: () {
                      GlobalTooltip.show('Back with blur');
                    },
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'With Blur',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
              // 示例2：无模糊效果的返回按钮
              Column(
                children: [
                  GlobalBackButton(
                    config: BackButtonConfig.noBlur(size: 25.0),
                    onTap: () {
                      GlobalTooltip.show('Back without blur');
                    },
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'No Blur',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 举报按钮示例
  /// Report Button Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 基础用法
  /// ReportButton(
  ///   size: 24,
  ///   image: 'assets/icons/report.png',
  ///   onTap: () {
  ///     // 处理举报逻辑
  ///   },
  /// )
  /// 
  /// // 带模糊效果
  /// ReportButton(
  ///   size: 24,
  ///   image: 'assets/icons/report.png',
  ///   isNeedBlur: true,
  ///   onTap: () {
  ///     // 处理举报逻辑
  ///   },
  /// )
  /// 
  /// // 自定义颜色
  /// ReportButton(
  ///   size: 24,
  ///   image: 'assets/icons/report.png',
  ///   color: Colors.red,
  ///   onTap: () {
  ///     // 处理举报逻辑
  ///   },
  /// )
  /// ```
  Widget _buildReportButtonExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Report button with optional blur effect and color.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 示例1：基础举报按钮
              Column(
                children: [
                  ReportButton(
                    size: 24,
                    image: 'assets/icons/report.png', // 替换为你的举报图标路径
                    onTap: () {
                      GlobalTooltip.show('Report clicked');
                    },
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Basic',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
              // 示例2：带模糊效果的举报按钮
              Column(
                children: [
                  ReportButton(
                    size: 24,
                    image: 'assets/icons/report.png',
                    isNeedBlur: true,
                    onTap: () {
                      GlobalTooltip.show('Report with blur');
                    },
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'With Blur',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
              // 示例3：自定义颜色的举报按钮
              Column(
                children: [
                  ReportButton(
                    size: 24,
                    image: 'assets/icons/report.png',
                    color: Colors.white,
                    onTap: () {
                      GlobalTooltip.show('Report with custom color');
                    },
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Custom Color',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

