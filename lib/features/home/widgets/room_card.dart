import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/room.dart';
import '../../../shared/widgets/press_effect.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback onTap;
  final int index;

  const RoomCard({
    super.key,
    required this.room,
    required this.onTap,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return PressEffect(
      onTap: onTap,
      child: Container(
        width: AppConstants.roomCardWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusCard),
          border: Border.all(color: AppColors.slate50),
          boxShadow: [
            BoxShadow(
              color: AppColors.slateShadow.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image with PAX badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
                  child: Image.network(
                    room.imageUrl,
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 160,
                      color: AppColors.slate100,
                      child: const Center(
                        child: Icon(Icons.image_outlined, color: AppColors.slate300, size: 40),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${room.capacity} PAX',
                      style: AppTypography.tag.copyWith(fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: AppTypography.headingMD.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    room.building.toUpperCase(),
                    style: AppTypography.labelSM.copyWith(
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
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
          begin: 0.2,
          duration: 500.ms,
          delay: Duration(milliseconds: 100 + (index * 120)),
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: const Offset(0.92, 0.92),
          duration: 500.ms,
          delay: Duration(milliseconds: 100 + (index * 120)),
          curve: Curves.easeOutCubic,
        );
  }
}
