import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/press_effect.dart';

class TimePickerRow extends StatelessWidget {
  const TimePickerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date picker
        PressEffect(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(AppConstants.radiusLG),
              border: Border.all(color: AppColors.slate100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TANGGAL', style: AppTypography.labelUppercase),
                    const SizedBox(height: 4),
                    Text(
                      'Senin, 17 Feb 2026',
                      style: AppTypography.bodySM,
                    ),
                  ],
                ),
                Icon(LucideIcons.calendar, size: 20, color: AppColors.slate300),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Time pickers
        Row(
          children: [
            Expanded(
              child: PressEffect(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.slate50,
                    borderRadius: BorderRadius.circular(AppConstants.radiusLG),
                    border: Border.all(color: AppColors.slate100),
                  ),
                  child: Column(
                    children: [
                      Text('MULAI', style: AppTypography.labelUppercase),
                      const SizedBox(height: 4),
                      Text('08:00 WIB', style: AppTypography.bodySM),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: PressEffect(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.slate50,
                    borderRadius: BorderRadius.circular(AppConstants.radiusLG),
                    border: Border.all(color: AppColors.slate100),
                  ),
                  child: Column(
                    children: [
                      Text('SELESAI', style: AppTypography.labelUppercase),
                      const SizedBox(height: 4),
                      Text('10:00 WIB', style: AppTypography.bodySM),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
