/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:beichuan_ui_components/src/config_export.dart';

/// 重叠头像组件 - 显示多个头像重叠排列
/// [avatarList]     - 头像URL列表
/// [headSize]       - 头像大小
/// [overlapOffset]  - 重叠偏移量（默认为头像大小的60%）
/// [borderWidth]    - 边框宽度
/// [borderColor]    - 边框颜色
/// [maxShowCount]   - 最大显示数量
/// [moreColor]      - 更多提示的背景色
/// [moreTextColor]  - 更多提示的文字颜色
class OverlapAvatar extends StatelessWidget {
  final List<String> avatarList;
  final double headSize;
  final double overlapOffset;
  final double borderWidth;
  final Color borderColor;
  final int? maxShowCount;
  final Color moreColor;
  final Color moreTextColor;

  const OverlapAvatar({
    super.key,
    required this.avatarList,
    required this.headSize,
    double? overlapOffset,
    this.borderWidth = 1.0,
    this.borderColor = const Color(0xFFFFFFFF),
    this.maxShowCount,
    this.moreColor = const Color(0xFFCCCCCC),
    this.moreTextColor = const Color(0xFFFFFFFF),
  }) : overlapOffset = overlapOffset ?? headSize * 0.6;

  @override
  Widget build(BuildContext context) {
    if (avatarList.isEmpty) return const SizedBox.shrink();

    final maxCount = maxShowCount ?? avatarList.length;
    final displayCount = avatarList.length > maxCount
        ? maxCount
        : avatarList.length;
    final remainingCount = avatarList.length - displayCount;
    final itemCount = displayCount + (remainingCount > 0 ? 1 : 0);
    final totalWidth = headSize + (itemCount - 1) * overlapOffset;

    return SizedBox(
      width: totalWidth,
      height: headSize,
      child: Stack(
        children: [
          // 显示头像列表
          ...List.generate(displayCount, (index) {
            return Positioned(
              left: index * overlapOffset,
              child: _circleContainer(
                child: ClipOval(
                  child: Image.asset(
                    avatarList[index],
                    width: headSize,
                    height: headSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
          // 显示更多指示器
          if (remainingCount > 0)
            Positioned(
              left: displayCount * overlapOffset,
              child: _circleContainer(
                backgroundColor: moreColor,
                child: Center(
                  child: Text(
                    '+$remainingCount',
                    style: TextStyle(
                      fontSize: headSize * 0.35,
                      fontWeight: FontWeight.bold,
                      color: moreTextColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 构建圆形容器 - 统一头像和指示器的容器样式
  Widget _circleContainer({Color? backgroundColor, required Widget child}) {
    return Container(
      width: headSize,
      height: headSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth.w),
      ),
      child: child,
    );
  }
}
