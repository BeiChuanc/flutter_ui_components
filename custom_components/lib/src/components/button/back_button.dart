/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:beichuan_ui_components/src/config_export.dart';

/// 返回按钮配置类
class BackButtonConfig {
  final bool backIcon;
  final double size;
  final bool hasBlur;
  final String image;
  const BackButtonConfig({this.size = 25.0, this.hasBlur = true, this.backIcon = true, this.image = ""});

  /// 无模糊效果的配置
  factory BackButtonConfig.noBlur({double size = 25.0}) {
    return BackButtonConfig(size: size, hasBlur: false);
  }
}

/// 返回按钮组件 - 提供统一的返回按钮样式
/// [config] - 按钮配置
/// [onTap]  - 自定义点击回调（默认为返回上一页）
class GlobalBackButton extends StatelessWidget {
  final BackButtonConfig config;
  final VoidCallback? onTap;

  const GlobalBackButton({
    super.key,
    this.config = const BackButtonConfig(),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.pop(context),
      child: config.backIcon
          ? (config.hasBlur ? _withBlur() : _withoutBlur())
          : imgIcon(config.size.w),
    );
  }

  /// 构建带模糊效果的按钮
  Widget _withBlur() {
    return GaussianBlur(
      radius: 12,
      paddingH: 8,
      paddingV: 8,
      gradientColors: [
        HexColor.fromHex("#FFFFFF"),
        HexColor.fromHex("#FFFFFF", opacity: 0.15),
      ],
      child: imgIcon(20.w),
    );
  }

  /// 构建不带模糊效果的按钮
  Widget _withoutBlur() {
    return imgIcon(config.size.w);
  }

  /// 构建图标
  Widget imgIcon(double size) {
    return Image.asset(
      config.image,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
