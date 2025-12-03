/*
 * Created by 周灿 on 2025/12/02.
 * email: 1486129104@qq.com
 */

// ignore: unnecessary_library_name
library custom_components;

/* 核心库 */
export 'dart:ui'
    show
        ImageFilter,
        BlendMode,
        Offset,
        Rect,
        Color,
        Paint,
        Canvas,
        Size,
        TextDirection,
        FontWeight,
        Locale;
export 'dart:io';
export 'dart:math';
export 'dart:async';
export 'dart:convert';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter/gestures.dart';

/* 三方库 */
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:bot_toast/bot_toast.dart';
export 'package:webview_flutter/webview_flutter.dart' hide X509Certificate;
export 'package:video_player/video_player.dart';
export 'package:crypto/crypto.dart';
export 'package:path_provider/path_provider.dart';
export 'package:video_thumbnail/video_thumbnail.dart';
export 'package:smooth_page_indicator/smooth_page_indicator.dart';

/* 组件模块 */
export 'components/extension/color.dart';                // 颜色扩展
export 'components/button/apple_login.dart';             // 苹果登录
export 'components/button/report_button.dart';           // 举报按钮
export 'components/button/back_button.dart';             // 返回按钮
export 'components/dialog/behavior_dialog_box.dart';     // 行为对话框
export 'components/dialog/global_tooltip.dart';          // 全局提示框
export 'components/dialog/report_component.dart';        // 举报对话框
export 'components/dialog/update_user_component.dart';   // 用户信息更新对话框
export 'components/media/media_player.dart';             // 媒体播放器
export 'components/media/media_showcase.dart';           // 媒体展示
export 'components/webview/webview_component.dart';      // 网页视图
export 'components/other/carousel.dart';                 // 轮播图
export 'components/other/danmaku_pool.dart';             // 弹幕池
export 'components/other/gaussian_blur.dart';            // 高斯模糊
export 'components/other/gloable_component.dart';        // 全局组件
export 'components/other/no_data_placeholder.dart';      // 无数据占位
export 'components/other/overlap_head.dart';             // 重叠头像
export 'components/other/protocol_text.dart';            // 协议文本
export 'components/other/rotation_button.dart';          // 旋转按钮
export 'components/other/slide_bottom.dart';             // 底部滑动
export 'components/other/tack_scroll.dart';              // 贴合滚动