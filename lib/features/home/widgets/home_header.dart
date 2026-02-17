import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Greeting row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SELAMAT PAGI,',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate400,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Abdul Alim',
                  style: AppTypography.headingBlack.copyWith(fontSize: 24),
                ),
              ],
            ),
            // Bell icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.slate100),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.slateShadow,
                      blurRadius: 8,
                      offset: const Offset(0, 2)),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(LucideIcons.bell,
                      size: 24, color: AppColors.slate700),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.amber500,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

        const SizedBox(height: 24),

        // Search bar
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.slate50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.slate100),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Icon(LucideIcons.search,
                    size: 20, color: AppColors.slate400),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Cari ruangan atau gedung...',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.slate400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.blue600,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(LucideIcons.slidersHorizontal,
                    size: 16, color: Colors.white),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
      ],
    );
  }
}
