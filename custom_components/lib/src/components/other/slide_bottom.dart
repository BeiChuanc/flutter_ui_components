/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:custom_ui_components/src/config_export.dart';

/// 底部滑动导航组件 - 提供带动画的底部导航栏
/// [selectedIndex]  - 当前选中的索引
/// [tabIcons]       - 导航栏图标路径列表
/// [onTabChanged]   - 切换回调
/// [customBackground] - 自定义背景组件（可选）
class SlideBottom extends StatefulWidget {
  final int selectedIndex;
  final List<String> tabIcons;
  final ValueChanged<int> onTabChanged;
  final Widget? customBackground;

  const SlideBottom({
    super.key,
    required this.selectedIndex,
    required this.tabIcons,
    required this.onTabChanged,
    this.customBackground,
  });

  @override
  State<SlideBottom> createState() => _SlideBottomState();
}

class _SlideBottomState extends State<SlideBottom>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  // 内联配置常量
  static const double _sidePadding = 0.0;
  static const double _itemWidth = 32.0;
  static const double _itemSpacing = 65.0;
  static const double _height = 80.0;
  static const double _borderRadius = 32.0;
  static const Color _backgroundColor = Colors.black;
  static const Color _selectedColor = Colors.white;
  static const Color _unselectedColor = Colors.white;
  static const double _bottomOffset = 0.0;
  static const double _indicatorSize = 45.0;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    _scaleController.forward();
  }

  @override
  void didUpdateWidget(covariant SlideBottom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _scaleController.reset();
      _scaleController.forward();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 计算选中项的中心位置
    final totalWidth =
        _itemWidth * widget.tabIcons.length +
        _itemSpacing * (widget.tabIcons.length - 1);
    final containerWidth = screenWidth - _sidePadding * 2;
    final startX = (containerWidth - totalWidth) / 2;
    final selectedLeft =
        startX +
        _itemWidth / 2 +
        widget.selectedIndex * (_itemWidth + _itemSpacing);

    return Positioned(
      bottom: _bottomOffset.h,
      left: _sidePadding.w,
      right: _sidePadding.w,
      child: Container(
        height: _height.h,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_borderRadius.r),
            topRight: Radius.circular(_borderRadius.r),
          ),
          border: Border(
            left: BorderSide(color: HexColor.fromHex("#FFFFFF"), width: 0.1.w),
            right: BorderSide(color: HexColor.fromHex("#FFFFFF"), width: 0.1.w),
            top: BorderSide(color: HexColor.fromHex("#FFFFFF"), width: 2.2.w),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 滑动指示器
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOutCubic,
              left: selectedLeft - (_indicatorSize / 2).w,
              top: (_height - _indicatorSize) / 2 - 5.h,
              child:
                  widget.customBackground ??
                  Container(
                    width: _indicatorSize.w,
                    height: _indicatorSize.w,
                    decoration: BoxDecoration(
                      color: _selectedColor,
                      shape: BoxShape.circle,
                    ),
                  ),
            ),
            // 导航项列表
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: _itemSpacing,
              children: List.generate(widget.tabIcons.length, (index) {
                final isSelected = widget.selectedIndex == index;
                return InkWell(
                  onTap: () {
                    if (widget.selectedIndex != index) {
                      widget.onTabChanged(index);
                    }
                  },
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) => Transform.scale(
                      scale: isSelected ? _scaleAnimation.value : 1.0,
                      child: Image.asset(
                        widget.tabIcons[index],
                        width: _itemWidth,
                        height: _itemWidth,
                        fit: BoxFit.contain,
                        color: isSelected ? _selectedColor : _unselectedColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
