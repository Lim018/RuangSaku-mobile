import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            // Avatar
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primaryYellow,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryYellow.withOpacity(0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(LucideIcons.user, size: 40, color: AppColors.slate900),
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .scale(begin: const Offset(0.5, 0.5), curve: Curves.easeOutBack),
            const SizedBox(height: 20),
            Text(
              'Mahasiswa',
              style: AppTypography.headingLG,
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 150.ms)
                .slideY(begin: 0.2, curve: Curves.easeOutCubic),
            const SizedBox(height: 4),
            Text(
              'nim@student.univ.ac.id',
              style: AppTypography.bodySM.copyWith(color: AppColors.slate400),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 250.ms),
            const SizedBox(height: 40),
            // Menu items
            ..._buildMenuItems(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    final items = [
      {'icon': LucideIcons.settings, 'label': 'Pengaturan'},
      {'icon': LucideIcons.helpCircle, 'label': 'Bantuan'},
      {'icon': LucideIcons.logOut, 'label': 'Keluar'},
    ];

    return items.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.slate50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.slate100),
        ),
        child: Row(
          children: [
            Icon(item['icon'] as IconData, size: 20, color: AppColors.slate400),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item['label'] as String,
                style: AppTypography.bodySM,
              ),
            ),
            const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.slate300),
          ],
        ),
      )
          .animate()
          .fadeIn(
            duration: 400.ms,
            delay: Duration(milliseconds: 350 + (i * 100)),
            curve: Curves.easeOutCubic,
          )
          .slideX(
            begin: 0.15,
            duration: 400.ms,
            delay: Duration(milliseconds: 350 + (i * 100)),
            curve: Curves.easeOutCubic,
          );
    }).toList();
  }
}
