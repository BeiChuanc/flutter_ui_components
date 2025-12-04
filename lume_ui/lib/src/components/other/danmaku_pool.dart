/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lume_ui/src/config_export.dart';

/// 弹幕项数据模型
class DanmakuPoolItem<T> {
  final String text;
  final AnimationController controller;
  final Animation<double> animation;
  final double speed;
  final Color textColor;
  final int trackIndex;
  final T? data;

  DanmakuPoolItem({
    required this.text,
    required this.controller,
    required this.animation,
    required this.speed,
    required this.textColor,
    required this.trackIndex,
    this.data,
  });
}

/// 弹幕池控制器
class DanmakuPoolController {
  DanmakuPoolState? _state;

  void _attach(DanmakuPoolState state) => _state = state;
  void _detach() => _state = null;

  /// 发布弹幕
  void publish(String text, {dynamic data, Color? color}) =>
      _state?._publishBarrage(text, data: data, color: color);

  /// 移除指定弹幕
  void remove(DanmakuPoolItem barrage) => _state?._removeBarrage(barrage);

  /// 清空所有弹幕
  void clear() => _state?._clearAll();

  /// 启动弹幕系统
  void start() => _state?._startSystem();

  /// 停止弹幕系统
  void stop() => _state?._stopSystem();

  /// 暂停弹幕动画
  void pause() => _state?._pauseAll();

  /// 恢复弹幕动画
  void resume() => _state?._resumeAll();

  /// 获取当前弹幕数量
  int get count => _state?._items.length ?? 0;

  /// 是否正在运行
  bool get isRunning => _state?._timer?.isActive ?? false;
}

/// 弹幕池配置类
class DanmakuPoolConfig {
  final int trackCount;
  final double trackHeight;
  final int emitInterval;
  final double baseSpeed;
  final double minSpeed;
  final double maxSpeed;
  final List<Color> textColors;
  final Color backgroundColor;
  final double topPadding;
  final double bottomPadding;

  const DanmakuPoolConfig({
    this.trackCount = 5,
    this.trackHeight = 36.0,
    this.emitInterval = 1500,
    this.baseSpeed = 8.0,
    this.minSpeed = 8.0,
    this.maxSpeed = 15.0,
    this.textColors = const [Color(0xFFCD01FE), Color(0xFF01ECF8)],
    this.backgroundColor = Colors.transparent,
    this.topPadding = 10.0,
    this.bottomPadding = 0.0,
  });
}

/// 弹幕池组件 - 管理和显示弹幕流
/// [controller]      - 弹幕控制器
/// [dataSource]      - 弹幕数据源
/// [textExtractor]   - 从数据对象提取文本的函数
/// [onBarrageTap]    - 弹幕点击回调
/// [config]          - 弹幕配置
/// [contentBuilder]  - 自定义弹幕内容构建器
/// [barrageBuilder]  - 自定义完整弹幕构建器
/// [autoStart]       - 是否自动启动
class DanmakuPool<T> extends StatefulWidget {
  final DanmakuPoolController? controller;
  final List<T> dataSource;
  final String Function(T data) textExtractor;
  final void Function(T data)? onBarrageTap;
  final DanmakuPoolConfig config;
  final Widget Function(BuildContext context, DanmakuPoolItem<T> item)?
  contentBuilder;
  final Widget Function(
    BuildContext context,
    DanmakuPoolItem<T> item,
    double containerWidth,
  )?
  barrageBuilder;
  final bool autoStart;

  const DanmakuPool({
    super.key,
    this.controller,
    required this.dataSource,
    required this.textExtractor,
    this.onBarrageTap,
    this.config = const DanmakuPoolConfig(),
    this.contentBuilder,
    this.barrageBuilder,
    this.autoStart = true,
  });

  @override
  State<DanmakuPool<T>> createState() => DanmakuPoolState<T>();
}

/// 弹幕池状态类
class DanmakuPoolState<T> extends State<DanmakuPool<T>>
    with TickerProviderStateMixin {
  final List<DanmakuPoolItem<T>> _items = [];
  final Random _random = Random();
  Timer? _timer;
  late List<bool> _trackOccupied;

  @override
  void initState() {
    super.initState();
    _trackOccupied = List.filled(widget.config.trackCount, false);
    widget.controller?._attach(this);
    if (widget.autoStart) _startSystem();
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _stopSystem();
    _clearAll();
    super.dispose();
  }

  /// 启动弹幕系统
  void _startSystem() {
    _stopSystem();
    _timer = Timer.periodic(
      Duration(milliseconds: widget.config.emitInterval),
      (_) => _addRandomBarrage(),
    );
  }

  /// 停止弹幕系统
  void _stopSystem() {
    _timer?.cancel();
    _timer = null;
  }

  /// 清空所有弹幕
  void _clearAll() {
    for (var item in _items) {
      item.controller.stop();
      item.controller.dispose();
    }
    _items.clear();
    _trackOccupied.fillRange(0, _trackOccupied.length, false);
  }

  /// 暂停所有弹幕动画
  void _pauseAll() {
    for (var item in _items) {
      if (item.controller.isAnimating) {
        item.controller.stop(canceled: false);
      }
    }
  }

  /// 恢复所有弹幕动画
  void _resumeAll() {
    for (var item in _items) {
      if (!item.controller.isAnimating && item.controller.value < 1.0) {
        item.controller.forward();
      }
    }
  }

  /// 获取可用的轨道索引
  int? _getAvailableTrack() {
    for (int i = 0; i < _trackOccupied.length; i++) {
      if (!_trackOccupied[i]) return i;
    }
    return null;
  }

  /// 释放指定轨道
  void _releaseTrack(int trackIndex) {
    if (trackIndex >= 0 && trackIndex < _trackOccupied.length) {
      _trackOccupied[trackIndex] = false;
    }
  }

  /// 随机选择颜色
  Color _randomColor() =>
      widget.config.textColors[_random.nextInt(
        widget.config.textColors.length,
      )];

  /// 创建弹幕项（核心逻辑）
  DanmakuPoolItem<T> _createItem({
    required String text,
    required int trackIndex,
    required Color color,
    T? data,
    double speedBoost = 0.0,
  }) {
    // 根据文本长度计算速度
    final extraTime = text.length / 12.0;
    final speed = (widget.config.baseSpeed + extraTime + speedBoost).clamp(
      widget.config.minSpeed + speedBoost,
      widget.config.maxSpeed + speedBoost,
    );

    final controller = AnimationController(
      duration: Duration(milliseconds: (speed * 1000).round()),
      vsync: this,
    );

    final animation = Tween<double>(
      begin: 1.0,
      end: -1.2,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    return DanmakuPoolItem<T>(
      text: text,
      controller: controller,
      animation: animation,
      speed: speed,
      textColor: color,
      trackIndex: trackIndex,
      data: data,
    );
  }

  /// 启动弹幕并管理生命周期
  void _launch(DanmakuPoolItem<T> item) {
    if (mounted) setState(() => _items.add(item));

    item.controller.forward().then((_) {
      if (mounted) {
        setState(() => _items.remove(item));
      } else {
        _items.remove(item);
      }
      _releaseTrack(item.trackIndex);
      item.controller.dispose();
    });
  }

  /// 通用的添加弹幕方法
  void _addBarrage({
    required String text,
    Color? color,
    T? data,
    double speedBoost = 0.0,
  }) {
    // 验证文本
    if (text.trim().isEmpty) return;

    // 检查是否有可用轨道
    final trackIndex = _getAvailableTrack();
    if (trackIndex == null) return;

    // 占用轨道
    _trackOccupied[trackIndex] = true;

    // 创建并启动弹幕
    final item = _createItem(
      text: text,
      trackIndex: trackIndex,
      color: color ?? _randomColor(),
      data: data,
      speedBoost: speedBoost,
    );

    _launch(item);
  }

  /// 从数据源添加随机弹幕
  void _addRandomBarrage() {
    if (widget.dataSource.isEmpty) return;

    final data = widget.dataSource[_random.nextInt(widget.dataSource.length)];
    final text = widget.textExtractor(data);

    _addBarrage(text: text, data: data);
  }

  /// 手动发布弹幕（供控制器调用）
  void _publishBarrage(String text, {dynamic data, Color? color}) {
    _addBarrage(
      text: text,
      color: color ?? HexColor.fromHex("#1C1C1C"),
      data: data as T?,
      speedBoost: 1.0, // 手动发布的弹幕速度更快
    );
  }

  /// 移除指定弹幕
  void _removeBarrage(DanmakuPoolItem<T> barrage) {
    if (mounted) setState(() => _items.remove(barrage));
  }

  /// 构建单个弹幕项
  Widget _buildBarrageItem(DanmakuPoolItem<T> item, double containerWidth) {
    return AnimatedBuilder(
      animation: item.animation,
      builder: (context, child) {
        return Positioned(
          left: item.animation.value * containerWidth,
          top:
              item.trackIndex * widget.config.trackHeight +
              widget.config.topPadding,
          child: InkWell(
            onTap: () {
              if (widget.onBarrageTap != null && item.data != null) {
                widget.onBarrageTap!(item.data as T);
              }
            },
            child: widget.contentBuilder!(context, item),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height:
          (widget.config.trackHeight * widget.config.trackCount +
                  widget.config.topPadding +
                  widget.config.bottomPadding)
              .h,
      decoration: BoxDecoration(
        color: widget.config.backgroundColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final containerWidth = constraints.maxWidth + 200.w;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // 空状态显示
                if (_items.isEmpty)
                  Center(
                    child: Text(
                      'No data',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: HexColor.fromHex('#999999'),
                      ),
                    ),
                  ),
                // 弹幕列表
                ..._items.map((item) {
                  return widget.barrageBuilder != null
                      ? widget.barrageBuilder!(context, item, containerWidth)
                      : _buildBarrageItem(item, containerWidth);
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
