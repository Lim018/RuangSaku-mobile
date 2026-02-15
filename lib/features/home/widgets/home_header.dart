import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryYellow,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SELAMAT PAGI,',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate800.withValues(alpha: 0.6),
                      letterSpacing: 2,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideX(begin: -0.2, curve: Curves.easeOutCubic),
                  const SizedBox(height: 4),
                  const Text(
                    'Arif Rahman',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate900,
                      height: 1,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 100.ms)
                      .slideX(begin: -0.2, curve: Curves.easeOutCubic),
                ],
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryYellow.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    'https://api.dicebear.com/7.x/avataaars/svg?seed=Arif',
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
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFB8860B).withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari gedung atau bilik...',
                hintStyle: TextStyle(
                  color: AppColors.slate400,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 12),
                  child: Icon(LucideIcons.search,
                      color: AppColors.slate400, size: 20),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms)
              .slideY(begin: 0.2, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }
}
