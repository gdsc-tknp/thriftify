import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const d0 = Color(0xFF39393B);
const d1 = Color(0xFF252525);
const d5 = Color(0xff003221);
const r0 = Color(0xFFFAFAFC);
const r1 = Color(0xffedeec9);
const r2 = Color(0xffdde7c7);
const r3 = Color(0xffbfd8bd);
const r4 = Color(0xff98c9a3);
const r5 = Color(0xff77bfa3);
const r6 = Color(0xff5CD1D7);
const t0 = Color(0xFFFBFBFB);
const td0 = Color(0xFF17262A);
const td1 = Color(0xFF3D3D3D);
const t1 = Color(0xFFEEEEEE);

ThemeData get theme {
  final base = ThemeData.light();
  return base.copyWith(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: r0,
    dividerColor: t1,
    dividerTheme: base.dividerTheme.copyWith(color: t1),
    bottomSheetTheme: base.bottomSheetTheme.copyWith(backgroundColor: t1),
    cardTheme: base.cardTheme.copyWith(
      // clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),cupertinoOverrideTheme: base.cupertinoOverrideTheme?.copyWith(),
    navigationBarTheme: base.navigationBarTheme.copyWith(height: 80),
    appBarTheme: base.appBarTheme.copyWith(
      // elevation: 1,
      scrolledUnderElevation: 0,
      centerTitle: true,
      toolbarHeight: 80,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: base.appBarTheme.titleTextStyle
          ?.copyWith(fontWeight: FontWeight.w400, fontSize: 18),
    ),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, td1, td0),
    textTheme: _buildTextTheme(base.textTheme, td1, td1),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
      accentColor: r6,
    ).copyWith(background: r3),
  );
}

ThemeData get themed {
  final base = ThemeData.dark();
  return base.copyWith(
    useMaterial3: true,
    primaryColorDark: d1,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: d1,
    primaryColor: d0,
    cardColor: d0,
    dividerColor: td1,
    dividerTheme: base.dividerTheme.copyWith(color: td1),
    cardTheme: base.cardTheme.copyWith(
      // clipBehavior: Clip.antiAlias,
      color: d0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    navigationBarTheme: base.navigationBarTheme.copyWith(),
    appBarTheme: base.appBarTheme.copyWith(
      // elevation: 1,
      scrolledUnderElevation: 0,
      centerTitle: true,
      toolbarHeight: 80,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: base.appBarTheme.titleTextStyle
          ?.copyWith(fontWeight: FontWeight.w400, fontSize: 18),
      color: d0,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: r0),
    textTheme: _buildTextTheme(base.textTheme, t1, t0),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, t1, t0),
    iconTheme: base.iconTheme.copyWith(color: r0),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
      accentColor: r6,
    ).copyWith(secondary: d0, background: d1),
  );
}

TextTheme _buildTextTheme(TextTheme base, Color displayColor, Color bodyColor) {
  return base
      .copyWith(
        headlineSmall: base.headlineSmall!.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          fontSize: 20,
        ),
        titleLarge: base.titleLarge!.copyWith(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          fontSize: 20,
        ),
        bodyLarge: base.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        titleMedium: base.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
          fontFamily: 'Poppins',
          displayColor: displayColor,
          bodyColor: bodyColor);
}
