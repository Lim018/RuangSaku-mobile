import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/booking.dart';
import '../../../shared/widgets/press_effect.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final int index;

  const BookingCard({
    super.key,
    required this.booking,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = booking.status == 'Active';

    return PressEffect(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(color: AppColors.slate50),
          boxShadow: [
            BoxShadow(
              color: AppColors.slateShadow.withOpacity(0.06),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Date badge
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.slate900,
                borderRadius: BorderRadius.circular(AppConstants.radiusLG),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    booking.month,
                    style: AppTypography.labelUppercase.copyWith(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 8,
                    ),
                  ),
                  Text(
                    booking.date,
                    style: AppTypography.headingLG.copyWith(
                      color: AppColors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.room,
                    style: AppTypography.headingMD.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking.time,
                    style: AppTypography.bodyXS,
                  ),
                ],
              ),
            ),
            // Status dot
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? AppColors.emerald500 : AppColors.slate300,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.emerald500.withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ]
                    : [],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 500.ms,
          delay: Duration(milliseconds: 100 + (index * 120)),
          curve: Curves.easeOutCubic,
        )
        .slideX(
          begin: 0.15,
          duration: 500.ms,
          delay: Duration(milliseconds: 100 + (index * 120)),
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          duration: 500.ms,
          delay: Duration(milliseconds: 100 + (index * 120)),
          curve: Curves.easeOutCubic,
        );
  }
}
