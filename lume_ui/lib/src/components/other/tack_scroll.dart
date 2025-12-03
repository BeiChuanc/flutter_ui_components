/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:lume_ui/src/config_export.dart';

/// 自定义滚动组件 背景图跟随滚动
/// * [image]           - 背景图片路径
/// * [child]           - 内容组件
/// * [fit]             - 图片适配方式
/// * [backgroundColor] - 背景色(当图片未覆盖完整区域时显示)
class TackScroll extends StatefulWidget {
  final String image;
  final Widget child;
  final BoxFit fit;
  final Color? backgroundColor;

  const TackScroll({
    super.key,
    required this.image,
    required this.child,
    this.fit = BoxFit.cover,
    this.backgroundColor,
  });

  @override
  State<TackScroll> createState() => _TackScrollState();
}

/// 自定义滚动组件状态类
class _TackScrollState extends State<TackScroll> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _contentKey = GlobalKey();
  double _scrollOffset = 0.0;
  double _contentHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
      _checkContentHeight();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkContentHeight());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 检查并更新内容高度
  void _checkContentHeight() {
    final renderBox =
        _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final newHeight = renderBox.size.height;
      if ((_contentHeight - newHeight).abs() > 0.1) {
        setState(() => _contentHeight = newHeight);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final contentHeight = _contentHeight > screenHeight
        ? _contentHeight
        : screenHeight;
    final maxScroll = _scrollController.hasClients
        ? _scrollController.position.maxScrollExtent
        : 0.0;

    // 计算背景偏移：下拉固定顶部(0)、正常跟随滚动、上拉对齐底部(maxOffset)
    final backgroundOffset = _scrollOffset < 0
        ? 0.0
        : (_scrollOffset > maxScroll && maxScroll > 0
              ? (contentHeight - screenHeight).clamp(0.0, double.infinity)
              : _scrollOffset);

    return Stack(
      children: [
        // 背景图层
        Positioned.fill(
          bottom: null,
          child: SizedBox(
            height: contentHeight,
            child: Transform.translate(
              offset: Offset(0, -backgroundOffset),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: widget.fit,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
        ),
        // 内容层
        SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Container(
            key: _contentKey,
            width: double.infinity,
            constraints: BoxConstraints(minHeight: screenHeight),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
