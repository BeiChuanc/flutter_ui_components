/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:lume_ui/src/config_export.dart';

/// 协议类型枚举
enum ProtocolType {
  terms('Terms of Service'),
  privacy('Privacy Policy'),
  eula('Eula');

  final String title;
  const ProtocolType(this.title);

  /// 跳转到协议页面
  void navigate(BuildContext context, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewComponent(type: this, content: content),
      ),
    );
  }
}

/// 协议文本配置类
/// [textColor]         - 普通文本颜色
/// [linkColor]         - 链接文本颜色
/// [fontSize]          - 字体大小
/// [fontWeight]        - 字体粗细
/// [hasUnderline]      - 链接是否有下划线
/// [prefixText]        - 前缀文本
/// [separatorText]     - 分隔符文本
class ProtocolTextConfig {
  final Color textColor;
  final Color linkColor;
  final double fontSize;
  final FontWeight fontWeight;
  final bool hasUnderline;
  final String prefixText;
  final String separatorText;

  const ProtocolTextConfig({
    Color? textColor,
    Color? linkColor,
    this.fontSize = 10.0,
    this.fontWeight = FontWeight.w400,
    this.hasUnderline = true,
    this.prefixText = 'By Continuing you agree with ',
    this.separatorText = ' & ',
  }) : textColor = textColor ?? const Color(0x99333333),
       linkColor = linkColor ?? const Color(0xFF333333);

  /// 浅色主题配置
  factory ProtocolTextConfig.light() {
    return const ProtocolTextConfig(
      textColor: Color(0x99333333),
      linkColor: Color(0xFF333333),
    );
  }

  /// 深色主题配置
  factory ProtocolTextConfig.dark() {
    return const ProtocolTextConfig(
      textColor: Color(0x99FFFFFF),
      linkColor: Color(0xFFFFFFFF),
    );
  }

  /// 自定义颜色配置
  factory ProtocolTextConfig.custom({
    required Color textColor,
    required Color linkColor,
    double fontSize = 10.0,
  }) {
    return ProtocolTextConfig(
      textColor: textColor,
      linkColor: linkColor,
      fontSize: fontSize,
    );
  }
}

/// 协议文本组件 - 显示服务条款和隐私政策
/// [firstProtocol]  - 协议一
/// [secondProtocol] - 协议二
/// [config]         - 文本配置
class ProtocolText extends StatelessWidget {
  final ProtocolType firstProtocol;
  final String firstProtocolContent;
  final ProtocolType secondProtocol;
  final String secondProtocolContent;
  final ProtocolTextConfig config;

  const ProtocolText({
    super.key,
    this.firstProtocol = .terms,
    this.firstProtocolContent = '',
    this.secondProtocol = .privacy,
    this.secondProtocolContent = '',
    this.config = const ProtocolTextConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          _textSpan(config.prefixText),
          _linkSpan(context, firstProtocol, firstProtocolContent),
          _textSpan(config.separatorText),
          _linkSpan(
            context,
            secondProtocol,
            secondProtocolContent,
            hasDot: true,
          ),
        ],
      ),
    );
  }

  /// 构建普通文本
  TextSpan _textSpan(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: config.textColor,
        fontSize: config.fontSize.sp,
        fontWeight: config.fontWeight,
      ),
    );
  }

  /// 构建链接文本
  TextSpan _linkSpan(
    BuildContext context,
    ProtocolType protocol,
    String content, {
    bool hasDot = false,
  }) {
    return TextSpan(
      text: hasDot ? '${protocol.title}.' : protocol.title,
      style: TextStyle(
        color: config.linkColor,
        fontSize: config.fontSize.sp,
        fontWeight: config.fontWeight,
        decoration: config.hasUnderline ? .underline : null,
        decorationColor: config.linkColor,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () => protocol.navigate(context, content),
    );
  }
}
