import 'package:flutter/widgets.dart';

import 'app_colors.dart';

abstract final class AppText {
  static const _f = 'Inter';

  static const TextStyle _base = TextStyle(
    fontFamily: _f,
    color: AppColors.ink,
    height: 1.0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle _s(
    double size,
    FontWeight w, {
    double? ls,
    double? lh,
    Color? c,
  }) => _base.copyWith(
    fontSize: size,
    fontWeight: w,
    letterSpacing: ls,
    height: lh == null ? null : lh / size,
    color: c,
  );

  // Display / headings
  /// `700 38px` — balance figure on the home card.
  static TextStyle get balance =>
      _s(38, FontWeight.w700, ls: -1.4, c: AppColors.white);

  /// `700 34px/40px` — onboarding headlines.
  static TextStyle get hero => _s(34, FontWeight.w700, ls: -1.1, lh: 40);

  /// `700 24px/32px` — screen titles.
  static TextStyle get title => _s(24, FontWeight.w700, ls: -0.7, lh: 32);

  /// `500 22px` — numeric emphasis (amounts in rows).
  static TextStyle get amount => _s(22, FontWeight.w500, ls: -0.6);

  /// `600 17px` — section headers, primary button label.
  static TextStyle get section => _s(17, FontWeight.w600, ls: -0.3);

  /// `600 16px` — merchant name.
  static TextStyle get name => _s(16, FontWeight.w600, ls: -0.2);

  // Body
  /// `400 15px/24px` — onboarding body copy.
  static TextStyle get body =>
      _s(15, FontWeight.w400, lh: 24, c: AppColors.inkSoft);

  /// `500 15px`
  static TextStyle get body15Medium => _s(15, FontWeight.w500);

  /// `600 15px`
  static TextStyle get body15Semi => _s(15, FontWeight.w600);

  /// `500 14.5px`
  static TextStyle get body145 => _s(14.5, FontWeight.w500);

  /// `600 14px` — row values, status-bar clock.
  static TextStyle get label14Semi => _s(14, FontWeight.w600, ls: -0.2);

  /// `500 14px` — row titles.
  static TextStyle get label14 => _s(14, FontWeight.w500, ls: -0.1);

  /// `500 13.5px`
  static TextStyle get label135 => _s(13.5, FontWeight.w500);

  /// `600 13px`
  static TextStyle get label13Semi => _s(13, FontWeight.w600, ls: -0.1);

  /// `500 13px` — "See all" links.
  static TextStyle get label13 => _s(13, FontWeight.w500);

  /// `400 13px`
  static TextStyle get body13 => _s(13, FontWeight.w400, c: AppColors.inkSoft);

  /// `500 12.5px`
  static TextStyle get label125 => _s(12.5, FontWeight.w500);

  /// `400 12.5px/19px`
  static TextStyle get body125 =>
      _s(12.5, FontWeight.w400, lh: 19, c: AppColors.inkSoft);

  /// `400 12px`
  static TextStyle get caption12 =>
      _s(12, FontWeight.w400, c: AppColors.inkMuted);

  /// `400 11.5px` — row subtitles, tile captions.
  static TextStyle get caption =>
      _s(11.5, FontWeight.w400, c: AppColors.inkMuted);

  /// `400 11.5px/18px`
  static TextStyle get caption18 =>
      _s(11.5, FontWeight.w400, lh: 18, c: AppColors.inkMuted);

  /// `400 11px`
  static TextStyle get caption11 =>
      _s(11, FontWeight.w400, c: AppColors.inkMuted);

  /// `600 10.5px` + 1.5px tracking, uppercase — eyebrow labels.
  static TextStyle get eyebrow =>
      _s(10.5, FontWeight.w600, ls: 1.5, c: AppColors.inkMuted);

  /// `700 10px` + 1px tracking — pills such as ACTIVE.
  static TextStyle get pill =>
      _s(10, FontWeight.w700, ls: 1.0, c: AppColors.white);

  /// `600 9.5px` + .4px tracking — bottom-nav labels.
  static TextStyle get navLabel => _s(9.5, FontWeight.w600, ls: 0.4);
}
