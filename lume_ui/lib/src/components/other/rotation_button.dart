/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:lume_ui/src/config_export.dart';

/// 旋转按钮工具类
class RotationButton {
  /// 创建旋转按钮组件
  /// [imagePath]  - 图片路径
  /// [imageSize]  - 图片大小
  /// [onTap]      - 点击回调
  /// [duration]   - 动画持续时间（毫秒）
  /// [fit]        - 图片适配方式
  /// [controller] - 控制器
  static Widget create({
    required String imagePath,
    required double imageSize,
    VoidCallback? onTap,
    int duration = 400,
    BoxFit fit = BoxFit.contain,
    RotationBtnController? controller,
  }) {
    return _RotationBtn(
      imagePath: imagePath,
      imageSize: imageSize,
      onTap: onTap,
      duration: duration,
      fit: fit,
      controller: controller,
    );
  }

  /// 创建快速旋转按钮（200ms）
  static Widget fast({
    required String imagePath,
    required double imageSize,
    VoidCallback? onTap,
    RotationBtnController? controller,
  }) => create(
    imagePath: imagePath,
    imageSize: imageSize,
    onTap: onTap,
    duration: 200,
    controller: controller,
  );

  /// 创建慢速旋转按钮（800ms）
  static Widget slow({
    required String imagePath,
    required double imageSize,
    VoidCallback? onTap,
    RotationBtnController? controller,
  }) => create(
    imagePath: imagePath,
    imageSize: imageSize,
    onTap: onTap,
    duration: 800,
    controller: controller,
  );
}

/// 旋转按钮控制器 - 用于外部控制旋转动画
class RotationBtnController {
  _RotationBtnState? _state;

  /// 触发旋转动画
  void rotate() => _state?._performRotation();

  /// 判断控制器是否已绑定组件
  bool get isAttached => _state != null;
}

/// 旋转按钮内部组件, 私有组件不对外暴露
class _RotationBtn extends StatefulWidget {
  final String imagePath;
  final double imageSize;
  final VoidCallback? onTap;
  final int duration;
  final BoxFit fit;
  final RotationBtnController? controller;

  const _RotationBtn({
    required this.imagePath,
    required this.imageSize,
    this.onTap,
    required this.duration,
    required this.fit,
    this.controller,
  });

  @override
  State<_RotationBtn> createState() => _RotationBtnState();
}

class _RotationBtnState extends State<_RotationBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    widget.controller?._state = this;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    if (widget.controller?._state == this) widget.controller?._state = null;
    _controller.dispose();
    super.dispose();
  }

  void _performRotation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _performRotation();
        widget.onTap?.call();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) =>
            Transform.rotate(angle: _animation.value * 2 * pi, child: child),
        child: Image.asset(
          widget.imagePath,
          width: widget.imageSize,
          height: widget.imageSize,
          fit: widget.fit,
        ),
      ),
    );
  }
}
