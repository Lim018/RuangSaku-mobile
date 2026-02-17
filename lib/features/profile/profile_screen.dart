import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // —— Blue Gradient Header ——
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 224,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primaryBlue,
                        AppColors.primaryBlueDark
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, top: 16),
                      child: const Text(
                        'AKUN SAYA',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ),
                // Avatar
                Positioned(
                  bottom: -64,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: AppColors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.slateShadow,
                              blurRadius: 30,
                              offset: const Offset(0, 10)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.network(
                          'https://api.dicebear.com/7.x/avataaars/svg?seed=Alim',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.slate100,
                            child: const Icon(LucideIcons.user,
                                size: 48, color: AppColors.slate400),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms),

            const SizedBox(height: 80),

            // —— User Info ——
            Text(
              'Abdul Alim',
              style: AppTypography.headingBlack.copyWith(fontSize: 24),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 4),

            Text(
              'TEKNIK INFORMATIKA',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.blue600,
                letterSpacing: 3,
              ),
            ).animate().fadeIn(delay: 300.ms),

            const SizedBox(height: 4),

            Text(
              'NIM: 434231022',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.slate400,
                letterSpacing: 3,
              ),
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 40),

            // —— Stats Card ——
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.slate800,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.slate200,
                        blurRadius: 20,
                        offset: const Offset(0, 8)),
                  ],
                ),
                child: Row(
                  children: [
                    _statItem('Semester', '6'),
                    _divider(),
                    _statItem('IPK', '3.85'),
                    _divider(),
                    _statItem('SKS', '124'),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 400.ms)
                .slideY(begin: 0.1),

            const SizedBox(height: 32),

            // —— Menu Items ——
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  _menuItem(
                    icon: LucideIcons.settings,
                    label: 'Pengaturan Aplikasi',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _menuItem(
                    icon: LucideIcons.logOut,
                    label: 'Keluar Sesi',
                    isLogout: true,
                    onTap: () => context.go('/login'),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms, duration: 400.ms),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 32,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isLogout ? AppColors.rose50 : AppColors.slate50,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: isLogout ? AppColors.rose100 : AppColors.slate100),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 20,
                color: isLogout ? AppColors.rose600 : AppColors.slate400),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isLogout ? AppColors.rose600 : AppColors.slate700,
                ),
              ),
            ),
            if (!isLogout)
              const Icon(LucideIcons.chevronRight,
                  size: 16, color: AppColors.slate300),
          ],
        ),
      ),
    );
  }
}
