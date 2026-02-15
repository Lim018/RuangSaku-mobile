import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/building.dart';
import '../../../shared/widgets/press_effect.dart';

class BuildingCard extends StatelessWidget {
  final Building building;
  final int index;
  final VoidCallback? onTap;

  const BuildingCard({
    super.key,
    required this.building,
    this.index = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PressEffect(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
          border: Border.all(color: building.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.slateShadow.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: building.bgColor,
                borderRadius: BorderRadius.circular(AppConstants.radiusLG),
              ),
              child: Icon(
                building.icon,
                color: building.iconColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              building.name.toUpperCase(),
              style: AppTypography.tag.copyWith(
                fontSize: 12,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${building.roomCount} RUANG',
              style: AppTypography.labelUppercase.copyWith(
                fontSize: 9,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 500.ms,
          delay: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeOutCubic,
        )
        .slideY(
          begin: 0.25,
          duration: 500.ms,
          delay: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: const Offset(0.85, 0.85),
          duration: 500.ms,
          delay: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeOutBack,
        );
  }
}
