import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_text.dart';
import 'app_icon.dart';
import 'glass.dart';

class AppField extends StatelessWidget {
  const AppField({
    super.key,
    required this.hint,
    this.icon,
    this.trailing,
    this.controller,
    this.keyboardType,
    this.obscure = false,
    this.readOnly = false,
    this.onTap,
    this.textStyle,
    this.dense = false,
  });

  final String hint;
  final String? icon;
  final Widget? trailing;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscure;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextStyle? textStyle;

  /// The tighter `12px 18px` padding the business-details step uses.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final style =
        textStyle ?? AppText.body.copyWith(color: AppColors.ink, height: 1.0);

    return GlassCard(
      radius: AppRadii.field,
      fill: .72,
      borderAlpha: .08,
      blur: 24,
      padding: dense
          ? const EdgeInsets.symmetric(horizontal: 18, vertical: 12)
          : const EdgeInsets.all(18),
      child: Row(
        children: [
          if (icon != null) ...[
            AppIcon(icon!, size: 20, color: AppColors.inkSoft),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.left,
              keyboardType: keyboardType,
              obscureText: obscure,
              readOnly: readOnly,
              onTap: onTap,
              style: style,
              cursorColor: AppColors.teal,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: hint,
                hintStyle: style.copyWith(color: AppColors.inkMuted),
              ),
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 12), trailing!],
        ],
      ),
    );
  }
}

/// A non-editable field that opens a picker — dates, times, categories.
class AppPickerField extends StatelessWidget {
  const AppPickerField({
    super.key,
    required this.hint,
    this.value,
    this.icon,
    this.trailing,
    this.onTap,
    this.dense = false,
    this.valueStyle,
  });

  final String hint;
  final String? value;
  final String? icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  /// The tighter `12px 18px` padding the business-details step uses.
  final bool dense;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final filled = value != null && value!.isNotEmpty;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GlassCard(
        radius: AppRadii.field,
        fill: .72,
        borderAlpha: .08,
        blur: 24,
        padding: dense
            ? const EdgeInsets.symmetric(horizontal: 18, vertical: 12)
            : const EdgeInsets.all(18),
        child: Row(
          children: [
            if (icon != null) ...[
              AppIcon(icon!, size: 20, color: AppColors.inkSoft),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                filled ? value! : hint,
                style: (valueStyle ?? AppText.body13).copyWith(
                  color: filled ? AppColors.slate : AppColors.inkMuted,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing!],
          ],
        ),
      ),
    );
  }
}

/// The low-emphasis alternative to [PrimaryButton] — frosted, not gradient.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GlassCard(
        radius: AppRadii.tile,
        fill: .72,
        borderAlpha: .11,
        blur: 24,
        padding: const EdgeInsets.all(19),
        child: Center(
          child: Text(label, style: AppText.body15Semi.copyWith(fontSize: 16)),
        ),
      ),
    );
  }
}

/// `──── OR ────`
class OrDivider extends StatelessWidget {
  const OrDivider({super.key, this.label = 'OR'});

  final String label;

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
      child: Container(height: 1, color: AppColors.slateA(.09)),
    );
    return Row(
      children: [
        line,
        const SizedBox(width: 14),
        Text(label, style: AppText.caption12),
        const SizedBox(width: 14),
        line,
      ],
    );
  }
}

/// The small teal-glyph note the design puts under forms.
class InfoNote extends StatelessWidget {
  const InfoNote({
    super.key,
    required this.text,
    this.icon = 'info',
    this.color = AppColors.tealDeep,
  });

  final String text;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: AppIcon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: AppText.caption18)),
      ],
    );
  }
}

/// The eyebrow + big figure + teal caret used for amount entry.
///
/// The design draws a static figure with a caret beside it. Pass a
/// [controller] to make it a real input; without one it renders [value] as
/// read-only display text.
class AmountEntry extends StatelessWidget {
  const AmountEntry({
    super.key,
    required this.label,
    this.value,
    this.controller,
    this.showCaret = true,
  }) : assert(
         value != null || controller != null,
         'AmountEntry needs either a value to display or a controller to edit',
       );

  final String label;
  final String? value;
  final TextEditingController? controller;
  final bool showCaret;

  @override
  Widget build(BuildContext context) {
    final figure = AppText.balance.copyWith(color: AppColors.ink);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.eyebrow),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (controller != null)
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: figure,
                  cursorColor: AppColors.teal,
                  cursorWidth: 2,
                  cursorHeight: 34,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              )
            else ...[
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(value!, maxLines: 1, style: figure),
                ),
              ),
              if (showCaret) ...[
                const SizedBox(width: 4),
                Container(
                  width: 2,
                  height: 34,
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ],
          ],
        ),
      ],
    );
  }
}
