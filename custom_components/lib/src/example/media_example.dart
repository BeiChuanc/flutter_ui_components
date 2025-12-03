/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 * 
 * 媒体组件示例
 * 展示 MediaPlayer、MediaShowCase、Carousel、WebViewComponent 的使用方法
 */

import 'package:custom_ui_components/src/config_export.dart';

/// 媒体组件示例页面
/// Media Components Example Page
class MediaExample extends StatelessWidget {
  const MediaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Examples'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Media ShowCase'),
            SizedBox(height: 12.h),
            _buildMediaShowCaseExample(context),
            SizedBox(height: 32.h),
            _buildSectionTitle('Carousel'),
            SizedBox(height: 12.h),
            _buildCarouselExample(context),
            SizedBox(height: 32.h),
            _buildSectionTitle('Media Player'),
            SizedBox(height: 12.h),
            _buildMediaPlayerExample(context),
            SizedBox(height: 32.h),
            _buildSectionTitle('WebView Component'),
            SizedBox(height: 12.h),
            _buildWebViewExample(context),
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

  /// 媒体展示组件示例
  /// Media ShowCase Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 展示本地图片
  /// MediaShowCase(
  ///   mediaUrl: 'assets/images/photo.jpg',
  ///   width: 200.w,
  ///   height: 150.h,
  ///   borderRadius: 12,
  /// )
  /// 
  /// // 展示网络视频（自动生成缩略图）
  /// MediaShowCase(
  ///   mediaUrl: 'https://example.com/video.mp4',
  ///   width: 200.w,
  ///   height: 150.h,
  ///   borderRadius: 12,
  /// )
  /// 
  /// // 展示本地视频
  /// MediaShowCase(
  ///   mediaUrl: '/path/to/video.mp4',
  ///   width: double.infinity,
  ///   height: 200.h,
  /// )
  /// ```
  Widget _buildMediaShowCaseExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display images and video thumbnails with auto-detection.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        // 示例：多种媒体类型
        Row(
          children: [
            // 本地图片示例
            Expanded(
              child: Column(
                children: [
                  MediaShowCase(
                    mediaUrl: 'assets/images/sample.jpg', // 替换为你的图片路径
                    width: 150.w,
                    height: 100.h,
                    borderRadius: 8,
                  ),
                  SizedBox(height: 4.h),
                  Text('Local Image', style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            // 视频缩略图示例
            Expanded(
              child: Column(
                children: [
                  MediaShowCase(
                    mediaUrl: 'assets/videos/sample.mp4', // 替换为你的视频路径
                    width: 150.w,
                    height: 100.h,
                    borderRadius: 8,
                  ),
                  SizedBox(height: 4.h),
                  Text('Video Thumbnail', style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 轮播图组件示例
  /// Carousel Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 基础轮播图
  /// Carousel(
  ///   images: [
  ///     'assets/images/1.jpg',
  ///     'assets/images/2.jpg',
  ///     'assets/images/3.jpg',
  ///   ],
  ///   width: double.infinity,
  ///   height: 200.h,
  ///   onTap: (index) {
  ///     print('Tapped image at index: $index');
  ///   },
  /// )
  /// 
  /// // 自定义指示器效果
  /// Carousel(
  ///   images: imageList,
  ///   width: double.infinity,
  ///   height: 200.h,
  ///   effectType: IndicatorEffectType.worm, // 可选: expanding, sliding, jumping, scale, worm
  ///   dotSize: 10.0,
  ///   dotSpacing: 6.0,
  ///   activeColor: Colors.blue,
  ///   inactiveColor: Colors.grey.withOpacity(0.3),
  ///   onTap: (index) {},
  /// )
  /// ```
  Widget _buildCarouselExample(BuildContext context) {
    // 示例图片列表
    final sampleImages = [
      'assets/images/banner1.jpg', // 替换为你的图片路径
      'assets/images/banner2.jpg',
      'assets/images/banner3.jpg',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Image/Video carousel with customizable indicators.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        // 示例：轮播图
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.grey[200],
          ),
          child: Carousel(
            images: sampleImages,
            width: double.infinity,
            height: 180.h,
            effectType: IndicatorEffectType.expanding,
            dotSize: 8.0,
            dotSpacing: 4.0,
            activeColor: HexColor.fromHex('#BDFF00'),
            inactiveColor: Colors.black.withOpacity(0.3),
            onTap: (index) {
              GlobalTooltip.show('Tapped image at index: $index');
            },
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Available indicator effects:',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
        Text(
          '• expanding (default)\n• sliding\n• jumping\n• scale\n• worm',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
      ],
    );
  }

  /// 媒体播放器示例
  /// Media Player Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 跳转到全屏媒体播放器页面
  /// Navigator.push(
  ///   context,
  ///   MaterialPageRoute(
  ///     builder: (context) => MediaPlayer(
  ///       mediaUrl: 'https://example.com/video.mp4',
  ///     ),
  ///   ),
  /// );
  /// 
  /// // 播放本地视频
  /// Navigator.push(
  ///   context,
  ///   MaterialPageRoute(
  ///     builder: (context) => MediaPlayer(
  ///       mediaUrl: '/path/to/local/video.mp4',
  ///     ),
  ///   ),
  /// );
  /// 
  /// // 查看图片（支持缩放）
  /// Navigator.push(
  ///   context,
  ///   MaterialPageRoute(
  ///     builder: (context) => MediaPlayer(
  ///       mediaUrl: 'https://example.com/image.jpg',
  ///     ),
  ///   ),
  /// );
  /// ```
  Widget _buildMediaPlayerExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full-screen media player for images and videos.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            // 播放视频按钮
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MediaPlayer(
                        mediaUrl: 'https://www.w3schools.com/html/mov_bbb.mp4', // 示例视频URL
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.play_circle),
                label: const Text('Play Video'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // 查看图片按钮
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MediaPlayer(
                        mediaUrl: 'https://picsum.photos/800/600', // 示例图片URL
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.image),
                label: const Text('View Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// WebView 组件示例
  /// WebView Component Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 使用 ProtocolType 枚举跳转
  /// ProtocolType.terms.navigate(context, 'https://example.com/terms');
  /// ProtocolType.privacy.navigate(context, 'https://example.com/privacy');
  /// ProtocolType.eula.navigate(context, 'https://example.com/eula');
  /// 
  /// // 直接使用 WebViewComponent
  /// Navigator.push(
  ///   context,
  ///   MaterialPageRoute(
  ///     builder: (context) => WebViewComponent(
  ///       type: ProtocolType.terms,
  ///       content: 'https://example.com/terms', // URL 或纯文本内容
  ///     ),
  ///   ),
  /// );
  /// 
  /// // 显示纯文本内容（非URL）
  /// Navigator.push(
  ///   context,
  ///   MaterialPageRoute(
  ///     builder: (context) => WebViewComponent(
  ///       type: ProtocolType.terms,
  ///       content: 'This is the terms of service content...',
  ///     ),
  ///   ),
  /// );
  /// ```
  Widget _buildWebViewExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WebView for displaying Terms, Privacy Policy, and EULA.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            // 服务条款
            ElevatedButton(
              onPressed: () {
                ProtocolType.terms.navigate(
                  context,
                  'https://www.google.com/intl/en/policies/terms/',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text('Terms of Service'),
            ),
            // 隐私政策
            ElevatedButton(
              onPressed: () {
                ProtocolType.privacy.navigate(
                  context,
                  'https://www.google.com/intl/en/policies/privacy/',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Privacy Policy'),
            ),
            // EULA
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebViewComponent(
                      type: ProtocolType.eula,
                      content: 'This is an example EULA content. '
                          'You can display plain text or a URL here. '
                          'The component automatically detects if the content '
                          'is a URL and loads it in WebView, otherwise displays '
                          'as scrollable text.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text('EULA (Text)'),
            ),
          ],
        ),
      ],
    );
  }
}

