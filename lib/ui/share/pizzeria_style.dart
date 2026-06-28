import 'package:flutter/material.dart';

class PizzeriaStyle {
  static const Color accentColor = Colors.amber;
  static const Color darkBackground = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);

  static final baseTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle pageTitleStyle = baseTextStyle.copyWith(
    fontSize: 28.0,
    color: accentColor,
    letterSpacing: 1.1,
  );

  static final TextStyle headerTextStyle = baseTextStyle.copyWith(
    fontSize: 20.0,
    color: Colors.white,
  );

  static final TextStyle regularTextStyle = baseTextStyle.copyWith(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
  );

  static final TextStyle subHeaderTextStyle = baseTextStyle.copyWith(
    fontSize: 24.0,
    color: accentColor,
  );

  static final TextStyle itemPriceTextStyle = const TextStyle(
    color: Colors.white60,
    fontSize: 16.0,
  );

  static final TextStyle subPriceTextStyle = baseTextStyle.copyWith(
    color: accentColor,
    fontSize: 20.0,
  );

  static final TextStyle priceSubTotalTextStyle = baseTextStyle.copyWith(
    color: Colors.white70,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle priceTotalTextStyle = baseTextStyle.copyWith(
    color: accentColor,
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
  );

  static final TextStyle errorTextStyle = baseTextStyle.copyWith(
    color: Colors.redAccent,
    fontSize: 18.0,
  );
}
