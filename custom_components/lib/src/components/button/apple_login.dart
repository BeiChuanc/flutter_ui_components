/*
 * Created by 周灿 on 2025/12/03.
 * email: 1486129104@qq.com
 */

import 'package:custom_ui_components/src/config_export.dart';

/// 苹果登录按钮
/// [image] 苹果图标图片
/// [appleLoginCallback] 登录回调
/// Apple Login Button
/// [image] Apple icon image
/// [appleLoginCallback] Login callback
class AppleLogin extends StatelessWidget {
  final String image;
  final VoidCallback appleLoginCallback;
  const AppleLogin({
    super.key,
    required this.image,
    required this.appleLoginCallback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: appleLoginCallback,
      child: Container(
        width: MediaQuery.of(context).size.width - 32.w,
        height: 58.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 22.w, height: 22.w, fit: BoxFit.contain),
            SizedBox(width: 10.w),
            Text(
              "Continue with Apple",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
