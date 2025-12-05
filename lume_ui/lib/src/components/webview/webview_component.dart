/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
*/

import 'package:flutter/material.dart';
import 'package:lume_ui/src/config_export.dart';

/// 协议网页视图组件 - 显示服务条款、隐私政策、EULA
/// * [type] - 协议类型
class WebViewComponent extends StatefulWidget {
  final ProtocolType type;
  final String content;
  const WebViewComponent({
    super.key,
    required this.type,
    required this.content,
  });

  @override
  State<WebViewComponent> createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<WebViewComponent> {
  late final WebViewController? _controller;
  bool _isLoading = true;

  bool get _hasRemoteUrl => widget.content.startsWith('http');

  @override
  void initState() {
    super.initState();
    if (_hasRemoteUrl) _initWebViewController();
  }

  /// 初始化 WebView 控制器
  void _initWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => _updateLoadingState(true),
          onPageFinished: (_) => _updateLoadingState(false),
          onWebResourceError: (_) => _updateLoadingState(false),
          onNavigationRequest: (_) => NavigationDecision.navigate,
        ),
      )
      ..loadRequest(Uri.parse(widget.content));
  }

  /// 更新加载状态
  void _updateLoadingState(bool isLoading) {
    if (mounted) setState(() => _isLoading = isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: .infinity,
        height: .infinity,
        child: Stack(
          children: [
            Column(
              children: [
                _buildTopBar(),
                Expanded(child: _contentArea()),
              ],
            ),
            if (_hasRemoteUrl && _isLoading) _loadingIndicator(),
            _buildHeader(),
          ],
        ),
      ),
    );
  }

  /// 构建顶部栏
  Widget _buildTopBar() {
    return Container(
      height: MediaQuery.of(context).padding.top + 44.h,
      color: Colors.white,
    );
  }

  /// 构建内容区域
  Widget _contentArea() {
    return _hasRemoteUrl
        ? WebViewWidget(controller: _controller!)
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: .symmetric(horizontal: 20.w, vertical: 16.h),
            child: Text(
              widget.content,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
  }

  /// 构建加载指示器
  Widget _loadingIndicator() {
    return Center(
      child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2.w),
    );
  }

  /// 构建头部（返回按钮和标题）
  Widget _buildHeader() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 16.w,
      right: 16.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GlobalBackButton(
            config: BackButtonConfig(hasBlur: false, color: Colors.black),
          ),
          Expanded(
            child: Text(
              widget.type.title,
              textAlign: .center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: .bold,
              ),
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }
}
