/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:lume_ui/src/config_export.dart';

/// 举报按钮组件
class ReportButton extends StatelessWidget {
  final double size;
  final VoidCallback? onTap;
  final bool isNeedBlur;
  final Color? color;
  final String image;

  const ReportButton({
    super.key,
    required this.size,
    this.onTap,
    this.isNeedBlur = false,
    this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final icon = Image.asset(
      image,
      width: size,
      height: size,
      fit: BoxFit.contain,
      color: color,
    );

    if (!isNeedBlur) return InkWell(onTap: onTap, child: icon);

    return InkWell(
      onTap: onTap,
      child: GaussianBlur(
        radius: 12,
        paddingH: 5,
        paddingV: 5,
        gradientColors: [
          HexColor.fromHex('#FFFFFF'),
          HexColor.fromHex('#FFFFFF', opacity: 0.15),
        ],
        child: icon,
      ),
    );
  }
}