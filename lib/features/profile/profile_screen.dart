import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profil',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.slate900,
                  letterSpacing: -0.5,
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOutCubic),

              const SizedBox(height: 40),

              // Avatar
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: AppColors.primaryYellow,
                          width: 4,
                        ),
                        color: AppColors.slate100,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.network(
                          'https://api.dicebear.com/7.x/avataaars/svg?seed=Arif',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.slate100,
                            child: const Icon(LucideIcons.user,
                                size: 48, color: AppColors.slate400),
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 100.ms).scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.easeOutBack),
                    const SizedBox(height: 24),
                    const Text(
                      'Arif Rahman',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.slate900,
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
                    const SizedBox(height: 4),
                    const Text(
                      'arif.rahman@univ.ac.id',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate400,
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Menu Items
              _MenuItem(
                icon: LucideIcons.settings,
                label: 'Tetapan',
                iconColor: AppColors.slate400,
                labelColor: AppColors.slate700,
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 400.ms)
                  .slideY(begin: 0.15, curve: Curves.easeOutCubic),

              const SizedBox(height: 16),

              _MenuItem(
                icon: LucideIcons.logOut,
                label: 'Log Keluar',
                iconColor: const Color(0xFFFB7185),
                labelColor: const Color(0xFFF43F5E),
                showChevron: false,
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 500.ms)
                  .slideY(begin: 0.15, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color labelColor;
  final bool showChevron;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.labelColor,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.slate100),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: labelColor,
              ),
            ),
          ),
          if (showChevron)
            const Icon(LucideIcons.chevronRight,
                size: 20, color: AppColors.slate300),
        ],
      ),
    );
  }
}
