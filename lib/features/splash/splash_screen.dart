import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Floating icon
              Container(
                width: AppConstants.splashIconSize,
                height: AppConstants.splashIconSize,
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow,
                  borderRadius: BorderRadius.circular(AppConstants.radiusIcon),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryYellow.withOpacity(0.4),
                      blurRadius: 40,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: const Icon(
                  LucideIcons.layoutGrid,
                  size: 64,
                  color: AppColors.slate900,
                ),
              )
                  .animate(
                    onPlay: (c) => c.repeat(reverse: true),
                  )
                  .moveY(
                    begin: 0,
                    end: -12,
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeInOut,
                  ),

              const SizedBox(height: 40),

              // Title
              Text(
                'RuangSaku',
                style: AppTypography.headingBlack.copyWith(fontSize: 40),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 300.ms)
                  .slideY(begin: 0.3, curve: Curves.easeOutCubic),

              const SizedBox(height: 8),

              // Tagline
              Text(
                'SMART ROOM BOOKING',
                style: AppTypography.labelUppercase.copyWith(
                  color: AppColors.slate400,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4,
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 500.ms)
                  .slideY(begin: 0.3, curve: Curves.easeOutCubic),

              const SizedBox(height: 96),

              // Arrow button
              GestureDetector(
                onTap: () => context.go('/login'),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.slate50,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.slate100),
                  ),
                  child: const Icon(
                    LucideIcons.chevronRight,
                    color: AppColors.slate900,
                  ),
                ),
              )
                  .animate(
                    onPlay: (c) => c.repeat(reverse: true),
                  )
                  .moveX(
                    begin: 0,
                    end: 6,
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeInOut,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 800.ms)
                  .scale(begin: const Offset(0.5, 0.5), curve: Curves.easeOutBack),
            ],
          ),
        ),
      ),
    );
  }
}
