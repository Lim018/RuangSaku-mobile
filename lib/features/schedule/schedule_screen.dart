import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../../dummy_data.dart';
import 'widgets/booking_card.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jadwal Saya',
                  style: AppTypography.headingBlack.copyWith(fontSize: 28),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.slate50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(LucideIcons.history, size: 20, color: AppColors.slate400),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(begin: -0.15, curve: Curves.easeOutCubic),

            const SizedBox(height: 28),

            // Booking list
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: DummyData.myBookings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return BookingCard(
                    booking: DummyData.myBookings[index],
                    index: index,
                  );
                },
              ),
            ),

            const SizedBox(height: AppConstants.navBarHeight),
          ],
        ),
      ),
    );
  }
}
