import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';

class RoomInfoChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final int index;

  const RoomInfoChip({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTypography.labelUppercase.copyWith(fontSize: 8),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTypography.bodyXS.copyWith(
              color: AppColors.slate800,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          duration: 400.ms,
          delay: Duration(milliseconds: 200 + (index * 100)),
          curve: Curves.easeOutCubic,
        )
        .slideY(
          begin: 0.3,
          duration: 400.ms,
          delay: Duration(milliseconds: 200 + (index * 100)),
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: const Offset(0.8, 0.8),
          duration: 400.ms,
          delay: Duration(milliseconds: 200 + (index * 100)),
          curve: Curves.easeOutBack,
        );
  }
}
