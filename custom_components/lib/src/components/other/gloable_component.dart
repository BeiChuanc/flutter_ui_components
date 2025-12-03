/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:custom_ui_components/src/config_export.dart';

/// 全局背景配置类
class GlobalScreenConfig {
  final String? backgroundImage;
  final bool resizeToAvoidBottomInset;
  final bool dismissKeyboardOnTap;


  const GlobalScreenConfig({
    this.backgroundImage,
    this.resizeToAvoidBottomInset = true,
    this.dismissKeyboardOnTap = true,
  });
}

/// 全局背景组件 - 提供统一的页面背景和布局
/// [contentChildren]          - 内容组件列表
/// [bottomChild]              - 底部固定组件
/// [config]                   - 全局配置
class GlobalScreenComponent extends StatelessWidget {
  final List<Widget> contentChildren;
  final Widget? bottomChild;
  final GlobalScreenConfig config;

  const GlobalScreenComponent({
    super.key,
    required this.contentChildren,
    this.bottomChild,
    this.config = const GlobalScreenConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: config.resizeToAvoidBottomInset,
      body: InkWell(
        onTap: config.dismissKeyboardOnTap
            ? () => FocusScope.of(context).unfocus()
            : null,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            if (config.backgroundImage != null) _buildBackground(),
            ...contentChildren,
            if (bottomChild != null) _buildBottom(),
          ],
        ),
      ),
    );
  }

  /// 构建背景图片
  Widget _buildBackground() {
    return Image.asset(
      config.backgroundImage ?? "",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  /// 构建底部组件
  Widget _buildBottom() {
    return Positioned(bottom: 0, left: 0, right: 0, child: bottomChild!);
  }
}

/// 顶部状态栏组件 - 提供左中右三区域布局
/// [leftChildren]   - 左侧组件列表
/// [centerChildren] - 中间组件列表
/// [rightChildren]  - 右侧组件列表
class GlobalStatusComponent extends StatelessWidget {
  final List<Widget>? leftChildren;
  final List<Widget>? centerChildren;
  final List<Widget>? rightChildren;

  const GlobalStatusComponent({
    super.key,
    this.leftChildren,
    this.centerChildren,
    this.rightChildren,
  });

  bool get _hasLeft => leftChildren?.isNotEmpty ?? false;
  bool get _hasCenter => centerChildren?.isNotEmpty ?? false;
  bool get _hasRight => rightChildren?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 左侧区域
        if (_hasLeft) ...leftChildren!,

        // 左侧 Spacer
        if (_hasLeft || _hasCenter) const Spacer(),

        // 中间区域
        if (_hasCenter) ...centerChildren!,

        // 右侧 Spacer
        if (_hasCenter || _hasRight) const Spacer(),

        // 右侧区域
        if (_hasRight) ...rightChildren!,
      ],
    );
  }
}


