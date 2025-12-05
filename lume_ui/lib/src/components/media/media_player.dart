/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lume_ui/src/config_export.dart';

/// 全屏媒体播放器
/// * [mediaUrl] - 媒体文件URL
class MediaPlayer extends StatefulWidget {
  final String mediaUrl;
  const MediaPlayer({super.key, required this.mediaUrl});

  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  // 视频文件扩展名
  static const List<String> _videoExtensions = [
    '.mp4',
    '.mov',
    '.avi',
    '.mkv',
    '.wmv',
    '.flv',
    '.m4v',
    '.3gp',
  ];

  // 视频URL模式
  static const List<String> _videoPatterns = [
    '/video/',
    'video=',
    'format=video',
  ];

  VideoPlayerController? _videoController;
  bool _isVideo = false;
  bool _isAsset = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initMedia();
  }

  // 初始化媒体
  void _initMedia() {
    _isAsset = widget.mediaUrl.startsWith('assets/');
    _isVideo = _detectVideoType();

    if (_isVideo) {
      _initVideoPlayer();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 检测媒体类型
  bool _detectVideoType() {
    final lowercaseUrl = widget.mediaUrl.toLowerCase();

    if (_videoExtensions.any((ext) => lowercaseUrl.endsWith(ext))) {
      return true;
    }

    if (widget.mediaUrl.startsWith('http')) {
      return _videoPatterns.any((pattern) => lowercaseUrl.contains(pattern)) ||
          _videoExtensions.any((ext) => lowercaseUrl.contains(ext));
    }

    return false;
  }

  // 初始化视频播放器
  Future<void> _initVideoPlayer() async {
    try {
      _videoController = _createVideoController();
      await _videoController!.initialize();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorSnackBar('Media loading failed: $e');
      }
    }
  }

  // 创建视频控制器
  VideoPlayerController _createVideoController() {
    if (_isAsset) {
      return VideoPlayerController.asset(widget.mediaUrl);
    } else if (widget.mediaUrl.startsWith('http')) {
      final uri = Uri.parse(widget.mediaUrl);
      return VideoPlayerController.networkUrl(uri);
    } else {
      return VideoPlayerController.file(File(widget.mediaUrl));
    }
  }

  // 媒体加载失败
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : _disPlayMediaContent(),
          ),
          _topBackBtn(context),
        ],
      ),
    );
  }

  // 顶部返回按钮
  Widget _topBackBtn(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10.h,
      left: 16.w,
      child: GlobalBackButton(
        config: BackButtonConfig(hasBlur: false, color: Colors.white),
      ),
    );
  }

  // 媒体内容
  Widget _disPlayMediaContent() {
    return _isVideo ? _videoPlayer() : _buildImageView();
  }

  // 错误组件
  Widget _buildErrorPlaceholder({required String message, IconData? icon}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon ?? Icons.error_outline, color: Colors.white, size: 48.w),
        SizedBox(height: 16.h),
        Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ],
    );
  }

  // 视频播放器
  Widget _videoPlayer() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return _buildErrorPlaceholder(message: 'Video Loading...');
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
        _playButton(),
      ],
    );
  }

  // 播放按钮
  Widget _playButton() {
    return GestureDetector(
      onTap: _playControl,
      child: _videoController!.value.isPlaying
          ? const SizedBox.shrink()
          : Icon(Icons.play_arrow, color: Colors.white, size: 60.w),
    );
  }

  // 播放控制
  void _playControl() {
    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
    });
  }

  // 图片视图
  Widget _buildImageView() {
    return InteractiveViewer(
      panEnabled: true,
      boundaryMargin: EdgeInsets.all(20.w),
      minScale: 0.5,
      maxScale: 4.0,
      child: _disPlayImage(),
    );
  }

  // 图片展示
  Widget _disPlayImage() {
    if (_isAsset) {
      return Image.asset(
        widget.mediaUrl,
        fit: BoxFit.contain,
        errorBuilder: _buildImageLoadError,
      );
    } else if (widget.mediaUrl.startsWith('http')) {
      return Image.network(
        widget.mediaUrl,
        fit: BoxFit.contain,
        loadingBuilder: _buildImageLoading,
        errorBuilder: (context, error, stackTrace) =>
            _buildErrorPlaceholder(message: 'Failed to load image'),
      );
    } else {
      return Image.file(
        File(widget.mediaUrl),
        fit: BoxFit.contain,
        errorBuilder: _buildImageLoadError,
      );
    }
  }

  // 图片加载中
  Widget _buildImageLoading(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: Colors.white,
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
              : null,
        ),
        SizedBox(height: 16.h),
        Text(
          'Loading image...',
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ],
    );
  }

  // 图片加载失败
  Widget _buildImageLoadError(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return _buildErrorPlaceholder(message: 'Image Loading...');
  }
}
