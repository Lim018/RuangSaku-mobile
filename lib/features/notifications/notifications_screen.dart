import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Notifikasi',
              style: AppTypography.headingBlack.copyWith(fontSize: 28),
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(begin: -0.15, curve: Curves.easeOutCubic),
            const SizedBox(height: 48),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      LucideIcons.bellOff,
                      size: 32,
                      color: AppColors.slate300,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .scale(begin: const Offset(0.5, 0.5), curve: Curves.easeOutBack),
                  const SizedBox(height: 20),
                  Text(
                    'Belum ada notifikasi',
                    style: AppTypography.bodySM.copyWith(color: AppColors.slate400),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 350.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
