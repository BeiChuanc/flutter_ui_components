/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:custom_components/src/config_export.dart';

/// 无数据占位组件
/// * [width]  - 图片宽度
/// * [height] - 图片高度
/// * [path]   - 图片路径
class NoDataPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final String path;
  const NoDataPlaceholder({
    super.key,
    required this.width,
    required this.height,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(path, width: width, height: height, fit: BoxFit.contain),
      ],
    );
  }
}
