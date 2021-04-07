import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kSpacingUnit = 10;

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Colors.black87;
const kLightPrimaryColor = Color.fromARGB(255, 41, 213, 178);
const kLightSecondaryColor = Color.fromARGB(255, 27, 164, 215);
const kAccentColor = Color(0xFFF3F7FB);

final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w200,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  primaryColor: kLightPrimaryColor,
  canvasColor: Colors.grey[350],
  backgroundColor: Color(0xFFF3F7FB),
  accentColor: kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: Color(0xFF212121),
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Montserrat',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
);
