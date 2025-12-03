/*
 * Created by 周灿 on 2025/12/02.
 * email: 1486129104@qq.com
 */

import 'package:custom_components/src/custom_components.dart';

/// Hexadecimal Color Conversion Utility
/// Supported Formats:
/// - 3-digit: #FFF / FFF → Equivalent to #FFFFFF
/// - 6-digit: #FFFFFF / FFFFFF → Automatically adds opacity to FF (completely opaque)
/// - 8-digit: FFFFFFFF → ARGB format (first digit is opacity, last six digits are color)
/// - The # symbol can be omitted for all formats.
class HexColor {
  /// Regex: Match 3/6/8-digit hexadecimal characters (without #)
  static const _hexRegex = r'^([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$';

  static const defaultColor = Colors.black;

  static Color fromHex(String hexString, {double opacity = 1.0}) {
    try {
      final cleanHex = hexString.replaceAll('#', '').trim();

      if (!RegExp(_hexRegex).hasMatch(cleanHex)) {
        debugPrint(
          'HexColor: Invalid hexadecimal format → $hexString, returning default color',
        );
        return defaultColor;
      }

      String argbHex;
      if (cleanHex.length == 3) {
        argbHex = 'FF${cleanHex.split('').map((c) => c * 2).join()}';
      } else if (cleanHex.length == 6) {
        argbHex = 'FF$cleanHex';
      } else {
        argbHex = cleanHex;
      }

      final color = Color(int.parse(argbHex, radix: 16));
      // ignore: deprecated_member_use
      return color.withOpacity(_opacityClamped(opacity));
    } catch (e, stack) {
      debugPrint(
        'HexColor: Conversion failed → $hexString, exception: $e, stack: $stack',
      );
      return defaultColor;
    }
  }

  static double _opacityClamped(double opacity) {
    return opacity.clamp(0.0, 1.0);
  }
}
