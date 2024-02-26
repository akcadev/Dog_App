import 'package:flutter/material.dart';

extension MediaQuerySize on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowValue => height * 0.02;
}

extension Sizer on BuildContext {
  EdgeInsets get allPadding => EdgeInsets.all(lowValue * 1);
  EdgeInsets get screenPaddingHorizontal =>
      const EdgeInsets.symmetric(horizontal: 16);
  BorderRadius get borderRadius => BorderRadius.circular(lowValue);
}
