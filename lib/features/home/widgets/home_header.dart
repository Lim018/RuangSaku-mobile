import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryYellow,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.radiusHeader),
          bottomRight: Radius.circular(AppConstants.radiusHeader),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
          child: Column(
            children: [
              // Top row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UNIVERSITAS PINTAR',
                        style: AppTypography.labelUppercase.copyWith(
                          color: AppColors.slate800,
                          fontSize: 10,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'RuangSaku',
                        style: AppTypography.headingXL.copyWith(
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideX(begin: -0.1, curve: Curves.easeOutCubic),
                  // Avatar
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.5), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryYellow.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        'https://api.dicebear.com/7.x/avataaars/svg?seed=Felix',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          LucideIcons.user,
                          color: AppColors.slate400,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 200.ms).scale(
                      begin: const Offset(0.5, 0.5), curve: Curves.easeOutBack),
                ],
              ),
              const SizedBox(height: 28),
              // Search bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppConstants.radiusXL),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryYellow.withOpacity(0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.search,
                        color: AppColors.slate400, size: 20),
                    const SizedBox(width: 14),
                    Text(
                      'Cari Kode Ruang atau Gedung...',
                      style: AppTypography.bodySM
                          .copyWith(color: AppColors.slate400),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 150.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }
}
