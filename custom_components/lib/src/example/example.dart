/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 * 
 * 组件示例入口文件
 * 统一导出所有示例页面
 */

// 导出所有示例页面
export 'button_example.dart';
export 'dialog_example.dart';
export 'media_example.dart';
export 'other_example.dart';

import 'package:custom_components/src/config_export.dart';
import 'button_example.dart';
import 'dialog_example.dart';
import 'media_example.dart';
import 'other_example.dart';

/// 示例主页面
/// Example Home Page
/// 
/// 使用方法:
/// ```dart
/// // 在你的应用中导航到示例页面
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => const ExampleHome()),
/// );
/// 
/// // 或者直接导航到特定示例
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => const ButtonExample()),
/// );
/// ```
class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Components Examples'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _buildExampleCard(
            context,
            title: 'Button Components',
            description: 'AppleLogin, GlobalBackButton, ReportButton',
            icon: Icons.touch_app,
            color: Colors.blue,
            onTap: () => _navigateTo(context, const ButtonExample()),
          ),
          SizedBox(height: 12.h),
          _buildExampleCard(
            context,
            title: 'Dialog Components',
            description: 'BehaviorDialogBox, GlobalTooltip, ReportDialog, UpdateUserDialog',
            icon: Icons.chat_bubble_outline,
            color: Colors.purple,
            onTap: () => _navigateTo(context, const DialogExample()),
          ),
          SizedBox(height: 12.h),
          _buildExampleCard(
            context,
            title: 'Media Components',
            description: 'MediaPlayer, MediaShowCase, Carousel, WebView',
            icon: Icons.play_circle_outline,
            color: Colors.red,
            onTap: () => _navigateTo(context, const MediaExample()),
          ),
          SizedBox(height: 12.h),
          _buildExampleCard(
            context,
            title: 'Other Components',
            description: 'GaussianBlur, DanmakuPool, OverlapAvatar, RotationButton, etc.',
            icon: Icons.widgets_outlined,
            color: Colors.teal,
            onTap: () => _navigateTo(context, const OtherExample()),
          ),
        ],
      ),
    );
  }

  /// 构建示例卡片
  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: Colors.white, size: 28.w),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 16.w,
            ),
          ],
        ),
      ),
    );
  }

  /// 导航到指定页面
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

