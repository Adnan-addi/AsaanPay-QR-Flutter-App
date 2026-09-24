import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';

/// The 48x28 pill switch: gradient when on, slate wash when off.
class AppToggle extends StatelessWidget {
  const AppToggle({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 48,
        height: 28,
        padding: const EdgeInsets.all(3),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
          gradient: value ? AppGradients.primary : null,
          color: value ? null : AppColors.slateA(.12),
          borderRadius: BorderRadius.circular(14),
          boxShadow: value
              ? [
                  BoxShadow(
                    color: AppColors.blueA(.60),
                    blurRadius: 16,
                    spreadRadius: -6,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.slateA(.24),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
