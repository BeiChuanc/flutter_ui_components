/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:lume_ui/src/config_export.dart';

/// 指示器效果类型枚举 - 5种效果
enum IndicatorEffectType { expanding, sliding, jumping, scale, worm }

/// 轮播图组件 - 支持图片/视频轮播展示
/// [images]        - 媒体URL列表
/// [width]         - 组件宽度
/// [height]        - 组件高度
/// [onTap]         - 点击回调（返回索引）
/// [effectType]    - 指示器效果类型（默认expanding）
/// [dotSize]       - 指示器点大小（默认8）
/// [dotSpacing]    - 指示器点间距（默认4）
/// [activeColor]   - 激活颜色（默认#BDFF00）
/// [inactiveColor] - 未激活颜色（默认半透明黑色）
class Carousel extends StatefulWidget {
  final List<String> images;
  final double? width;
  final double? height;
  final Function(int) onTap;
  final IndicatorEffectType effectType;
  final double dotSize;
  final double dotSpacing;
  final Color activeColor;
  final Color inactiveColor;

  const Carousel({
    super.key,
    required this.images,
    this.width,
    this.height,
    required this.onTap,
    this.effectType = IndicatorEffectType.expanding,
    this.dotSize = 8.0,
    this.dotSpacing = 4.0,
    this.activeColor = const Color(0xFFBDFF00),
    this.inactiveColor = const Color(0x4D000000),
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 创建指示器效果 - 5种效果
  IndicatorEffect _createIndicatorEffect() {
    final size = widget.dotSize.w;
    final spacing = widget.dotSpacing.w;
    final active = widget.activeColor;
    final inactive = widget.inactiveColor;

    switch (widget.effectType) {
      case IndicatorEffectType.sliding:
        return SlideEffect(
          dotWidth: size,
          dotHeight: size,
          spacing: spacing,
          activeDotColor: active,
          dotColor: inactive,
        );
      case IndicatorEffectType.jumping:
        return JumpingDotEffect(
          dotWidth: size,
          dotHeight: size,
          spacing: spacing,
          activeDotColor: active,
          dotColor: inactive,
        );
      case IndicatorEffectType.scale:
        return ScaleEffect(
          dotWidth: size,
          dotHeight: size,
          spacing: spacing,
          activeDotColor: active,
          dotColor: inactive,
          scale: 1.5,
        );
      case IndicatorEffectType.worm:
        return WormEffect(
          dotWidth: size,
          dotHeight: size,
          spacing: spacing,
          activeDotColor: active,
          dotColor: inactive,
        );
      case IndicatorEffectType.expanding:
        return ExpandingDotsEffect(
          dotWidth: size,
          dotHeight: size,
          spacing: spacing,
          activeDotColor: active,
          dotColor: inactive,
          expansionFactor: 3.0,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        spacing: 5.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => widget.onTap(index),
                child: MediaShowCase(
                  mediaUrl: widget.images[index],
                  width: widget.width ?? double.infinity,
                  height: widget.height ?? double.infinity,
                ),
              ),
            ),
          ),
          if (widget.images.length > 1)
            SmoothPageIndicator(
              controller: _controller,
              count: widget.images.length,
              effect: _createIndicatorEffect(),
            ),
        ],
      ),
    );
  }
}
