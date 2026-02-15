import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../dummy_data.dart';
import 'widgets/booking_card.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Jadual Saya',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      LucideIcons.filter,
                      size: 20,
                      color: AppColors.slate400,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOutCubic),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: DummyData.myBookings.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 24),
                  itemBuilder: (context, index) {
                    return BookingCard(
                      booking: DummyData.myBookings[index],
                    )
                        .animate()
                        .fadeIn(
                          duration: 500.ms,
                          delay: (100 * index).ms,
                        )
                        .slideY(
                          begin: 0.15,
                          delay: (100 * index).ms,
                          curve: Curves.easeOutCubic,
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
