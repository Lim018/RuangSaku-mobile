import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../dummy_data.dart';

class BookedScreen extends StatelessWidget {
  const BookedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = DummyData.myBookings;

    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Riwayat Booking',
                style: AppTypography.headingBlack.copyWith(fontSize: 28),
              ).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 24),
              Expanded(
                child: bookings.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.calendarOff,
                                size: 48, color: AppColors.slate300),
                            const SizedBox(height: 12),
                            const Text(
                              'Belum Ada Booking',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate300),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: bookings.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, i) {
                          final b = bookings[i];
                          return GestureDetector(
                            onTap: () => context.push('/booked-detail/${b.id}'),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(color: AppColors.slate100),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.slate200
                                        .withValues(alpha: 0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Date badge
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: AppColors.slate900,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          b.month,
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white
                                                .withValues(alpha: 0.4),
                                          ),
                                        ),
                                        Text(
                                          b.date,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          b.room.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.slate900,
                                            letterSpacing: -0.5,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: b.statusBgColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                b.status,
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w900,
                                                  color: b.statusColor,
                                                  letterSpacing: -0.3,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              b.session,
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.slate400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(LucideIcons.chevronRight,
                                      size: 20, color: AppColors.slate300),
                                ],
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(
                                  delay: (200 + i * 100).ms, duration: 300.ms)
                              .slideY(begin: 0.1);
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
