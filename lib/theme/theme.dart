import 'dart:ui';

import 'package:flutter/material.dart';

const d0 = Color(0xFF39393B);
const d1 = Color(0xFF2D2D2D);
const d5 = Color(0xff003221);
const r0 = Color(0xFFFAFAFC);
const r1 = Color(0xffedeec9);
const r2 = Color(0xffdde7c7);
const r3 = Color(0xffbfd8bd);
const r4 = Color(0xff98c9a3);
const r5 = Color(0xff77bfa3);

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.teal,
    accentColor: r5,
  ),
  // backgroundColor: r3,
  scaffoldBackgroundColor: r0,
  cardTheme: CardTheme(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  appBarTheme: const AppBarTheme(
    // elevation: 1,
    scrolledUnderElevation: 0,
    centerTitle: true,
    toolbarHeight: 80,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 18,
    ),
  ),
  fontFamily: 'Poppins',
  useMaterial3: true,
);
ThemeData themed = ThemeData(
  primaryColorDark: d1,
  // backgroundColor: r3,
  scaffoldBackgroundColor: d1,
  cardTheme: CardTheme(
    clipBehavior: Clip.antiAlias,
    color: d0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  appBarTheme: const AppBarTheme(
    // elevation: 1,
    scrolledUnderElevation: 0,
    centerTitle: true,
    toolbarHeight: 80,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 18,
    ),
    color: d0,
  ),
  fontFamily: 'Poppins',
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.teal,
    accentColor: r5,
  ).copyWith(
    secondary: d0,
  ),
);
