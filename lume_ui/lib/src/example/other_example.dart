/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 * 
 * 其他组件示例
 * 展示 GaussianBlur、DanmakuPool、GlobalScreenComponent、NoDataPlaceholder、
 * OverlapAvatar、ProtocolText、RotationButton、SlideBottom、TackScroll、HexColor 的使用方法
 */

import 'package:lume_ui/src/config_export.dart';

/// 其他组件示例页面
/// Other Components Example Page
class OtherExample extends StatefulWidget {
  const OtherExample({super.key});

  @override
  State<OtherExample> createState() => _OtherExampleState();
}

class _OtherExampleState extends State<OtherExample> {
  final DanmakuPoolController _danmakuController = DanmakuPoolController();
  final RotationBtnController _rotationController = RotationBtnController();
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Examples'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('HexColor Extension'),
            SizedBox(height: 12.h),
            _buildHexColorExample(),
            SizedBox(height: 32.h),
            _buildSectionTitle('Gaussian Blur'),
            SizedBox(height: 12.h),
            _buildGaussianBlurExample(),
            SizedBox(height: 32.h),
            _buildSectionTitle('Danmaku Pool (Barrage)'),
            SizedBox(height: 12.h),
            _buildDanmakuPoolExample(),
            SizedBox(height: 32.h),
            _buildSectionTitle('Overlap Avatar'),
            SizedBox(height: 12.h),
            _buildOverlapAvatarExample(),
            SizedBox(height: 32.h),
            _buildSectionTitle('Rotation Button'),
            SizedBox(height: 12.h),
            _buildRotationButtonExample(),
            SizedBox(height: 32.h),
            _buildSectionTitle('No Data Placeholder'),
            SizedBox(height: 12.h),
            _buildNoDataPlaceholderExample(),
            SizedBox(height: 32.h),
            _buildSectionTitle('Protocol Text'),
            SizedBox(height: 12.h),
            _buildProtocolTextExample(),
            SizedBox(height: 32.h),
            _buildSectionTitle('Slide Bottom Navigation'),
            SizedBox(height: 12.h),
            _buildSlideBottomExample(),
            SizedBox(height: 32.h),
            _buildSectionTitle('Tack Scroll'),
            SizedBox(height: 12.h),
            _buildTackScrollExample(context),
            SizedBox(height: 32.h),
            _buildSectionTitle('Global Screen Component'),
            SizedBox(height: 12.h),
            _buildGlobalScreenExample(context),
            SizedBox(height: 50.h),
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

  /// HexColor 扩展示例
  /// HexColor Extension Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 3位十六进制颜色
  /// Color color1 = HexColor.fromHex('#FFF');      // 白色
  /// Color color2 = HexColor.fromHex('F00');       // 红色
  /// 
  /// // 6位十六进制颜色
  /// Color color3 = HexColor.fromHex('#FF5722');   // 橙色
  /// Color color4 = HexColor.fromHex('2196F3');    // 蓝色
  /// 
  /// // 8位十六进制颜色 (ARGB)
  /// Color color5 = HexColor.fromHex('80FF5722');  // 半透明橙色
  /// 
  /// // 使用 opacity 参数
  /// Color color6 = HexColor.fromHex('#FF5722', opacity: 0.5);
  /// ```
  Widget _buildHexColorExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Convert hex strings to Flutter Color objects.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            _colorBox('#FF5722', HexColor.fromHex('#FF5722')),
            _colorBox('#2196F3', HexColor.fromHex('#2196F3')),
            _colorBox('#4CAF50', HexColor.fromHex('#4CAF50')),
            _colorBox('#FFF (3-digit)', HexColor.fromHex('#FFF')),
            _colorBox('opacity: 0.5', HexColor.fromHex('#000000', opacity: 0.5)),
          ],
        ),
      ],
    );
  }

  Widget _colorBox(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(fontSize: 10.sp)),
      ],
    );
  }

  /// 高斯模糊示例
  /// Gaussian Blur Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 基础用法
  /// GaussianBlur(
  ///   child: Text('Blurred Background'),
  /// )
  /// 
  /// // 自定义配置
  /// GaussianBlur(
  ///   child: yourWidget,
  ///   radius: 20.0,           // 圆角
  ///   paddingH: 16.0,         // 水平内边距
  ///   paddingV: 12.0,         // 垂直内边距
  ///   hasBorder: true,        // 显示边框
  ///   hasShadow: true,        // 显示阴影
  ///   hasTilt: true,          // 倾斜效果
  ///   blurSigma: 20.0,        // 模糊程度
  ///   gradientColors: [       // 渐变颜色
  ///     Colors.black,
  ///     Colors.black.withOpacity(0.5),
  ///   ],
  /// )
  /// ```
  Widget _buildGaussianBlurExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frosted glass effect with customizable blur.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Container(
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            image: const DecorationImage(
              image: NetworkImage('https://picsum.photos/400/200'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: GaussianBlur(
              radius: 16,
              paddingH: 20,
              paddingV: 12,
              hasBorder: true,
              blurSigma: 15,
              gradientColors: [
                HexColor.fromHex('#000000', opacity: 0.6),
                HexColor.fromHex('#000000', opacity: 0.3),
              ],
              child: Text(
                'Gaussian Blur Effect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 弹幕池示例
  /// Danmaku Pool Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 创建控制器
  /// final controller = DanmakuPoolController();
  /// 
  /// // 基础用法
  /// DanmakuPool<String>(
  ///   controller: controller,
  ///   dataSource: ['Hello', 'World', 'Flutter'],
  ///   textExtractor: (data) => data,
  ///   onBarrageTap: (data) {
  ///     print('Tapped: $data');
  ///   },
  /// )
  /// 
  /// // 自定义配置
  /// DanmakuPool<YourModel>(
  ///   controller: controller,
  ///   dataSource: modelList,
  ///   textExtractor: (model) => model.text,
  ///   config: DanmakuPoolConfig(
  ///     trackCount: 5,        // 轨道数量
  ///     trackHeight: 36.0,    // 轨道高度
  ///     emitInterval: 1500,   // 发射间隔(ms)
  ///     baseSpeed: 8.0,       // 基础速度
  ///     textColors: [Colors.purple, Colors.cyan],
  ///   ),
  ///   autoStart: true,
  /// )
  /// 
  /// // 控制器方法
  /// controller.publish('New message');  // 发布弹幕
  /// controller.start();                 // 开始
  /// controller.stop();                  // 停止
  /// controller.pause();                 // 暂停
  /// controller.resume();                // 恢复
  /// controller.clear();                 // 清空
  /// ```
  Widget _buildDanmakuPoolExample() {
    final sampleData = [
      'Hello Flutter!',
      'This is amazing',
      'Danmaku rocks!',
      'Great component',
      'Love this!',
      'Awesome work',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Scrolling barrage/bullet comments system.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: DanmakuPool<String>(
            controller: _danmakuController,
            dataSource: sampleData,
            textExtractor: (data) => data,
            onBarrageTap: (data) {
              GlobalTooltip.show('Tapped: $data');
            },
            config: DanmakuPoolConfig(
              trackCount: 3,
              trackHeight: 30.0,
              emitInterval: 2000,
              textColors: [
                HexColor.fromHex('#CD01FE'),
                HexColor.fromHex('#01ECF8'),
                HexColor.fromHex('#BDFF00'),
              ],
            ),
            contentBuilder: (context, item) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: item.textColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  item.text,
                  style: TextStyle(color: item.textColor, fontSize: 12.sp),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _danmakuController.stop(),
              icon: const Icon(Icons.stop),
            ),
            IconButton(
              onPressed: () => _danmakuController.start(),
              icon: const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () => _danmakuController.publish('Custom Message!'),
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }

  /// 重叠头像示例
  /// Overlap Avatar Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 基础用法
  /// OverlapAvatar(
  ///   avatarList: [
  ///     'assets/avatar1.png',
  ///     'assets/avatar2.png',
  ///     'assets/avatar3.png',
  ///   ],
  ///   headSize: 40.w,
  /// )
  /// 
  /// // 自定义配置
  /// OverlapAvatar(
  ///   avatarList: avatarList,
  ///   headSize: 50.w,
  ///   overlapOffset: 25.w,      // 重叠偏移量
  ///   borderWidth: 2.0,         // 边框宽度
  ///   borderColor: Colors.white, // 边框颜色
  ///   maxShowCount: 4,          // 最大显示数量
  ///   moreColor: Colors.grey,   // "更多"指示器背景色
  ///   moreTextColor: Colors.white, // "更多"文字颜色
  /// )
  /// ```
  Widget _buildOverlapAvatarExample() {
    final avatarList = [
      'assets/avatars/avatar1.png', // 替换为你的头像路径
      'assets/avatars/avatar2.png',
      'assets/avatars/avatar3.png',
      'assets/avatars/avatar4.png',
      'assets/avatars/avatar5.png',
      'assets/avatars/avatar6.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display multiple overlapping avatars.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                OverlapAvatar(
                  avatarList: avatarList.take(3).toList(),
                  headSize: 40.w,
                ),
                SizedBox(height: 8.h),
                Text('3 Avatars', style: TextStyle(fontSize: 12.sp)),
              ],
            ),
            Column(
              children: [
                OverlapAvatar(
                  avatarList: avatarList,
                  headSize: 40.w,
                  maxShowCount: 4,
                  moreColor: HexColor.fromHex('#666666'),
                ),
                SizedBox(height: 8.h),
                Text('Max 4 + more', style: TextStyle(fontSize: 12.sp)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// 旋转按钮示例
  /// Rotation Button Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 创建控制器（可选）
  /// final controller = RotationBtnController();
  /// 
  /// // 基础用法
  /// RotationButton.create(
  ///   imagePath: 'assets/icons/refresh.png',
  ///   imageSize: 30,
  ///   onTap: () {
  ///     // 处理点击
  ///   },
  /// )
  /// 
  /// // 快速旋转（200ms）
  /// RotationButton.fast(
  ///   imagePath: 'assets/icons/refresh.png',
  ///   imageSize: 30,
  ///   onTap: () {},
  /// )
  /// 
  /// // 慢速旋转（800ms）
  /// RotationButton.slow(
  ///   imagePath: 'assets/icons/refresh.png',
  ///   imageSize: 30,
  ///   onTap: () {},
  /// )
  /// 
  /// // 使用控制器
  /// RotationButton.create(
  ///   imagePath: 'assets/icons/refresh.png',
  ///   imageSize: 30,
  ///   controller: controller,
  ///   onTap: () {},
  /// )
  /// // 在其他地方触发旋转
  /// controller.rotate();
  /// ```
  Widget _buildRotationButtonExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Button with rotation animation on tap.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                RotationButton.fast(
                  imagePath: 'assets/icons/refresh.png', // 替换为你的图标路径
                  imageSize: 40,
                  onTap: () {
                    GlobalTooltip.show('Fast rotation (200ms)');
                  },
                ),
                SizedBox(height: 8.h),
                Text('Fast', style: TextStyle(fontSize: 12.sp)),
              ],
            ),
            Column(
              children: [
                RotationButton.create(
                  imagePath: 'assets/icons/refresh.png',
                  imageSize: 40,
                  duration: 400,
                  controller: _rotationController,
                  onTap: () {
                    GlobalTooltip.show('Normal rotation (400ms)');
                  },
                ),
                SizedBox(height: 8.h),
                Text('Normal', style: TextStyle(fontSize: 12.sp)),
              ],
            ),
            Column(
              children: [
                RotationButton.slow(
                  imagePath: 'assets/icons/refresh.png',
                  imageSize: 40,
                  onTap: () {
                    GlobalTooltip.show('Slow rotation (800ms)');
                  },
                ),
                SizedBox(height: 8.h),
                Text('Slow', style: TextStyle(fontSize: 12.sp)),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Center(
          child: ElevatedButton(
            onPressed: () => _rotationController.rotate(),
            child: const Text('Trigger via Controller'),
          ),
        ),
      ],
    );
  }

  /// 无数据占位组件示例
  /// No Data Placeholder Example
  /// 
  /// 使用方法:
  /// ```dart
  /// NoDataPlaceholder(
  ///   width: 200.w,
  ///   height: 200.h,
  ///   path: 'assets/images/no_data.png',
  /// )
  /// ```
  Widget _buildNoDataPlaceholderExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Placeholder for empty data states.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Center(
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: NoDataPlaceholder(
              width: 100.w,
              height: 100.h,
              path: 'assets/images/no_data.png', // 替换为你的无数据图片路径
            ),
          ),
        ),
      ],
    );
  }

  /// 协议文本示例
  /// Protocol Text Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 基础用法
  /// ProtocolText(
  ///   firstProtocol: ProtocolType.terms,
  ///   firstProtocolContent: 'https://example.com/terms',
  ///   secondProtocol: ProtocolType.privacy,
  ///   secondProtocolContent: 'https://example.com/privacy',
  /// )
  /// 
  /// // 浅色主题
  /// ProtocolText(
  ///   firstProtocolContent: termsUrl,
  ///   secondProtocolContent: privacyUrl,
  ///   config: ProtocolTextConfig.light(),
  /// )
  /// 
  /// // 深色主题
  /// ProtocolText(
  ///   firstProtocolContent: termsUrl,
  ///   secondProtocolContent: privacyUrl,
  ///   config: ProtocolTextConfig.dark(),
  /// )
  /// 
  /// // 自定义配置
  /// ProtocolText(
  ///   firstProtocolContent: termsUrl,
  ///   secondProtocolContent: privacyUrl,
  ///   config: ProtocolTextConfig(
  ///     textColor: Colors.grey,
  ///     linkColor: Colors.blue,
  ///     fontSize: 12.0,
  ///     hasUnderline: true,
  ///     prefixText: 'By signing up, you agree to our ',
  ///     separatorText: ' and ',
  ///   ),
  /// )
  /// ```
  Widget _buildProtocolTextExample() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms and Privacy Policy text with tappable links.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        // 浅色主题
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ProtocolText(
            firstProtocol: ProtocolType.terms,
            firstProtocolContent: 'https://www.google.com/intl/en/policies/terms/',
            secondProtocol: ProtocolType.privacy,
            secondProtocolContent: 'https://www.google.com/intl/en/policies/privacy/',
            config: ProtocolTextConfig.light(),
          ),
        ),
        SizedBox(height: 12.h),
        // 深色主题
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: ProtocolText(
            firstProtocol: ProtocolType.terms,
            firstProtocolContent: 'Terms content or URL',
            secondProtocol: ProtocolType.privacy,
            secondProtocolContent: 'Privacy content or URL',
            config: ProtocolTextConfig.dark(),
          ),
        ),
      ],
    );
  }

  /// 底部滑动导航示例
  /// Slide Bottom Navigation Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // 在 Stack 中使用
  /// Stack(
  ///   children: [
  ///     // 页面内容...
  ///     SlideBottom(
  ///       selectedIndex: _currentIndex,
  ///       tabIcons: [
  ///         'assets/icons/home.png',
  ///         'assets/icons/search.png',
  ///         'assets/icons/profile.png',
  ///       ],
  ///       onTabChanged: (index) {
  ///         setState(() => _currentIndex = index);
  ///       },
  ///       customBackground: Container(...), // 可选自定义背景
  ///     ),
  ///   ],
  /// )
  /// ```
  Widget _buildSlideBottomExample() {
    final tabIcons = [
      'assets/icons/home.png',     // 替换为你的图标路径
      'assets/icons/search.png',
      'assets/icons/add.png',
      'assets/icons/profile.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Animated bottom navigation bar with sliding indicator.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Stack(
            children: [
              SlideBottom(
                selectedIndex: _selectedTabIndex,
                tabIcons: tabIcons,
                onTabChanged: (index) {
                  setState(() => _selectedTabIndex = index);
                  GlobalTooltip.show('Tab $index selected');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 贴合滚动示例
  /// Tack Scroll Example
  /// 
  /// 使用方法:
  /// ```dart
  /// TackScroll(
  ///   image: 'assets/images/background.jpg',
  ///   fit: BoxFit.cover,
  ///   backgroundColor: Colors.black,
  ///   child: Column(
  ///     children: [
  ///       // 你的内容组件...
  ///     ],
  ///   ),
  /// )
  /// ```
  Widget _buildTackScrollExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Scrollable content with background that follows scroll.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const _TackScrollDemo()),
            );
          },
          child: const Text('View TackScroll Demo'),
        ),
      ],
    );
  }

  /// 全局屏幕组件示例
  /// Global Screen Component Example
  /// 
  /// 使用方法:
  /// ```dart
  /// // GlobalScreenComponent - 页面容器
  /// GlobalScreenComponent(
  ///   config: GlobalScreenConfig(
  ///     backgroundImage: 'assets/images/bg.png',
  ///     resizeToAvoidBottomInset: true,
  ///     dismissKeyboardOnTap: true,
  ///   ),
  ///   contentChildren: [
  ///     // 内容组件...
  ///   ],
  ///   bottomChild: YourBottomWidget(),
  /// )
  /// 
  /// // GlobalStatusComponent - 状态栏布局
  /// GlobalStatusComponent(
  ///   leftChildren: [BackButton()],
  ///   centerChildren: [Text('Title')],
  ///   rightChildren: [MenuButton()],
  /// )
  /// ```
  Widget _buildGlobalScreenExample(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Page container with background and status bar components.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 12.h),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const _GlobalScreenDemo()),
            );
          },
          child: const Text('View GlobalScreen Demo'),
        ),
      ],
    );
  }
}

/// TackScroll 演示页面
class _TackScrollDemo extends StatelessWidget {
  const _TackScrollDemo();

  @override
  Widget build(BuildContext context) {
    return TackScroll(
      image: 'assets/images/background.jpg', // 替换为你的背景图片
      fit: BoxFit.cover,
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  GlobalBackButton(
                    config: BackButtonConfig(hasBlur: true),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'TackScroll Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(20, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Item ${index + 1}',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// GlobalScreen 演示页面
class _GlobalScreenDemo extends StatelessWidget {
  const _GlobalScreenDemo();

  @override
  Widget build(BuildContext context) {
    return GlobalScreenComponent(
      config: GlobalScreenConfig(
        backgroundImage: 'assets/images/background.jpg', // 替换为你的背景图片
        dismissKeyboardOnTap: true,
      ),
      contentChildren: [
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 状态栏组件示例
                GlobalStatusComponent(
                  leftChildren: [
                    GlobalBackButton(
                      config: BackButtonConfig(hasBlur: true),
                    ),
                  ],
                  centerChildren: [
                    Text(
                      'GlobalScreen Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  rightChildren: [
                    ReportButton(
                      size: 24,
                      image: 'assets/icons/menu.png',
                      isNeedBlur: true,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  'This is the GlobalScreenComponent demo page.',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
      ],
      bottomChild: Container(
        height: 60.h,
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Text(
            'Bottom Widget',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}

