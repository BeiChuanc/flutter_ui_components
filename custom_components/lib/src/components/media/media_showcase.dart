/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:custom_ui_components/src/config_export.dart';

enum MediaOfType {
  networkVideo,
  assetsImage,
  assetsVideo,
  localVideo,
  localImage,
}

enum MediaOfStatus { loading, success, error, initial }

/// 全局缩略图缓存管理器
class MediaThumbnailCache {
  static final _instance = MediaThumbnailCache._internal();
  factory MediaThumbnailCache() => _instance;
  MediaThumbnailCache._internal();

  final Map<String, Future<String?>> _generating = {};
  final Map<String, String> _completed = {};

  /// 获取或生成缩略图
  Future<String?> getOrGenerateThumbnail(
    String url,
    Future<String?> Function() generator,
  ) async {
    final key = md5.convert(utf8.encode(url)).toString();

    if (_completed.containsKey(key)) return _completed[key];
    if (_generating.containsKey(key)) {
      final result = await _generating[key];
      if (result != null) _completed[key] = result;
      _generating.remove(key);
      return result;
    }

    final future = generator();
    _generating[key] = future;

    try {
      final result = await future;
      if (result != null) _completed[key] = result;
      return result;
    } finally {
      _generating.remove(key);
    }
  }

  void clearCache() {
    _completed.clear();
    _generating.clear();
  }
}

/// 媒体展示组件 - 支持图片和视频的展示
/// [mediaUrl]     - 媒体URL
/// [width]        - 宽度
/// [height]       - 高度
/// [borderRadius] - 圆角大小
class MediaShowCase extends StatefulWidget {
  final String mediaUrl;
  final double width;
  final double? height;
  final double? borderRadius;

  const MediaShowCase({
    super.key,
    required this.mediaUrl,
    required this.width,
    this.height,
    this.borderRadius,
  });

  @override
  State<MediaShowCase> createState() => _MediaShowCaseState();
}

class _MediaShowCaseState extends State<MediaShowCase> {
  String? _thumbnailPath;
  MediaOfStatus _loadState = MediaOfStatus.initial;

  static const _videoExts = {
    '.mp4',
    '.avi',
    '.mov',
    '.wmv',
    '.flv',
    '.mkv',
    '.webm',
    '.m4v',
    '.mpg',
    '.mpeg',
    '.3gp',
    '.m3u8',
    '.ts',
  };

  @override
  void initState() {
    super.initState();
    _loadVideoCover();
  }

  @override
  void didUpdateWidget(MediaShowCase oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaUrl != widget.mediaUrl) {
      setState(() {
        _thumbnailPath = null;
        _loadState = MediaOfStatus.initial;
      });
      _loadVideoCover();
    }
  }

  /// 判断是否为视频
  bool get _isVideo {
    final path = widget.mediaUrl.toLowerCase().split('?')[0];
    return _videoExts.any((ext) => path.endsWith(ext)) ||
        path.contains('/hls/') ||
        path.contains('/m3u8');
  }

  /// 获取媒体类型
  MediaOfType get _mediaType {
    final url = widget.mediaUrl;
    if (url.startsWith('http')) return _isVideo ? MediaOfType.networkVideo : MediaOfType.localImage;
    if (url.startsWith('assets')) return _isVideo ? MediaOfType.assetsVideo : MediaOfType.assetsImage;
    return _isVideo ? MediaOfType.localVideo : MediaOfType.localImage;
  }

  /// 加载视频封面
  Future<void> _loadVideoCover() async {
    if (!_isVideo) return;
    if (!mounted) return;

    setState(() => _loadState = MediaOfStatus.loading);

    try {
      final thumbnail = await MediaThumbnailCache().getOrGenerateThumbnail(
        widget.mediaUrl,
        () => _generateThumbnail(),
      );

      if (mounted) {
        setState(() {
          _thumbnailPath = thumbnail;
          _loadState = thumbnail != null
              ? MediaOfStatus.success
              : MediaOfStatus.error;
        });
      }
    } catch (e) {
      debugPrint('load video cover failed: $e');
      if (mounted) setState(() => _loadState = MediaOfStatus.error);
    }
  }

  /// 生成视频缩略图
  Future<String?> _generateThumbnail({
    int quality = 75,
    int maxSize = 400,
  }) async {
    try {
      final cacheDir = await _getCacheDir();
      final key = md5.convert(utf8.encode(widget.mediaUrl)).toString();
      final cachePath = '$cacheDir/$key.jpg';

      // 检查缓存
      if (await _isValidCache(cachePath)) return cachePath;

      // 处理 assets 视频
      String videoPath = widget.mediaUrl;
      if (_mediaType == MediaOfType.assetsVideo) {
        final tempPath = await _copyAssetToTemp();
        if (tempPath == null) {
          return quality > 60
              ? _generateThumbnail(quality: 60, maxSize: 200)
              : null;
        }
        videoPath = tempPath;
      }

      // 生成缩略图
      final thumbnail = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: cachePath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: maxSize,
        maxHeight: maxSize,
        quality: quality,
        timeMs: 500,
      );

      return (thumbnail != null && await _isValidCache(thumbnail))
          ? thumbnail
          : null;
    } catch (e) {
      debugPrint('generate thumbnail failed: $e');
      return quality > 60
          ? _generateThumbnail(quality: 60, maxSize: 200)
          : null;
    }
  }

  /// 复制 assets 视频到临时文件
  Future<String?> _copyAssetToTemp() async {
    try {
      final cacheDir = await _getCacheDir();
      final key = md5.convert(utf8.encode(widget.mediaUrl)).toString();
      final videoPath = '$cacheDir/${key}_video.mp4';

      final file = File(videoPath);
      if (file.existsSync()) return videoPath;

      final byteData = await rootBundle.load(widget.mediaUrl);
      await file.writeAsBytes(byteData.buffer.asUint8List());
      return videoPath;
    } catch (e) {
      debugPrint('copy assets video failed: $e');
      return null;
    }
  }

  /// 获取缓存目录
  Future<String> _getCacheDir() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final cacheDir = Directory('${tempDir.path}/video_thumbnails');
      await cacheDir.create(recursive: true);
      return cacheDir.path;
    } catch (e) {
      final appDir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory('${appDir.path}/video_thumbnails');
      await cacheDir.create(recursive: true);
      return cacheDir.path;
    }
  }

  /// 验证缓存文件
  Future<bool> _isValidCache(String path) async {
    try {
      final file = File(path);
      if (!file.existsSync()) return false;
      if (file.lengthSync() < 1024) return false;

      final daysDiff = DateTime.now()
          .difference(file.statSync().modified)
          .inDays;
      if (daysDiff > 7) {
        await file.delete();
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 构建图片组件（统一处理）
  Widget _imageHandle(ImageProvider provider) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0.r),
      child: Image(
        image: provider,
        width: widget.width,
        height: widget.height ?? 160.h,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _placeholder(
          icon: Icons.broken_image_outlined,
          text: 'Image error',
        ),
      ),
    );
  }

  /// 构建占位符（统一处理）
  Widget _placeholder({
    required IconData icon,
    required String text,
    String? subText,
    VoidCallback? onTap,
  }) {
    final content = Container(
      width: widget.width,
      height: widget.height ?? 160.h,
      decoration: BoxDecoration(
        color: HexColor.fromHex('#F5F5F5'),
        borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 0.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon == Icons.refresh)
              SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: HexColor.fromHex('#666666'),
                ),
              )
            else
              Icon(icon, color: HexColor.fromHex('#666666'), size: 24.w),
            SizedBox(height: 4.h),
            Text(
              text,
              style: TextStyle(fontSize: 10.sp, color: HexColor.fromHex('#666666')),
            ),
            if (subText != null) ...[
              SizedBox(height: 2.h),
              Text(
                subText,
                style: TextStyle(fontSize: 8.sp, color: HexColor.fromHex('#555555')),
              ),
            ],
          ],
        ),
      ),
    );

    return onTap != null ? InkWell(onTap: onTap, child: content) : content;
  }

  /// 构建视频缩略图
  Widget _videoThumbnail() {
    if (_thumbnailPath == null) return _placeholder(icon: Icons.videocam, text: 'Video');

    return SizedBox(
      width: widget.width,
      height: widget.height ?? 160.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _imageHandle(FileImage(File(_thumbnailPath!))),
          Icon(Icons.play_arrow, color: Colors.white, size: 40.w),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final type = _mediaType;

    // 图片类型
    if (type == MediaOfType.assetsImage) return _imageHandle(AssetImage(widget.mediaUrl));
    if (type == MediaOfType.localImage) return _imageHandle(FileImage(File(widget.mediaUrl)));

    // 视频类型
    switch (_loadState) {
      case MediaOfStatus.loading:
        return _placeholder(icon: Icons.refresh, text: 'Loading');
      case MediaOfStatus.success:
        return _videoThumbnail();
      case MediaOfStatus.error:
        return _placeholder(
          icon: Icons.error_outline,
          text: 'Video error',
          subText: 'Tap to retry',
          onTap: () {
            setState(() => _loadState = MediaOfStatus.initial);
            _loadVideoCover();
          },
        );
      case MediaOfStatus.initial:
        return _placeholder(
          icon: Icons.videocam,
          text: 'Tap to load',
          onTap: _loadVideoCover,
        );
    }
  }
}
