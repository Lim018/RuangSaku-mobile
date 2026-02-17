import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../dummy_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // —— Header: Greeting + Bell ——
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
                        style:
                            AppTypography.headingBlack.copyWith(fontSize: 24),
                      ),
                    ],
                  ),
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
                            offset: const Offset(0, 2))
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
                              border:
                                  Border.all(color: AppColors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

              const SizedBox(height: 24),

              // —— Search Bar ——
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
                            color: AppColors.slate400),
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

              const SizedBox(height: 32),

              // —— Recent Room ——
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Room',
                      style: AppTypography.headingBlack.copyWith(fontSize: 18)),
                  GestureDetector(
                    onTap: () => context.go('/explore'),
                    child: Text('Lihat Semua',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blue600)),
                  ),
                ],
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

              const SizedBox(height: 16),

              // Horizontal Room Carousel
              SizedBox(
                height: 260,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: DummyData.popularRooms.length.clamp(0, 3),
                  separatorBuilder: (_, __) => const SizedBox(width: 20),
                  itemBuilder: (context, index) {
                    final room = DummyData.popularRooms[index];
                    return GestureDetector(
                      onTap: () => context.push('/room/${room.id}'),
                      child: Container(
                        width: 280,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: AppColors.slate100),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.slateShadow,
                                blurRadius: 8,
                                offset: const Offset(0, 4))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(32)),
                                  child: Image.network(
                                    room.imageUrl,
                                    height: 176,
                                    width: 280,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      height: 176,
                                      color: AppColors.slate100,
                                      child: const Icon(LucideIcons.image,
                                          color: AppColors.slate300, size: 40),
                                    ),
                                  ),
                                ),
                                // Heart
                                Positioned(
                                  top: 16,
                                  right: 16,
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      LucideIcons.heart,
                                      size: 16,
                                      color: room.isFavorite
                                          ? AppColors.rose500
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                // Badge
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.blue600
                                          .withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'BARU DIBUKA',
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          letterSpacing: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Info
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 14, 20, 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    room.name.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.slate900,
                                        letterSpacing: -0.5),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    room.building.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.slate400,
                                        letterSpacing: 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: (400 + index * 100).ms, duration: 400.ms)
                        .slideX(begin: 0.2);
                  },
                ),
              ),

              const SizedBox(height: 32),

              // —— Daftar Gedung ——
              Text('Daftar Gedung',
                      style: AppTypography.headingBlack.copyWith(fontSize: 18))
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 400.ms),

              const SizedBox(height: 24),

              // Building grid 4x2
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.75,
                ),
                itemCount: DummyData.buildings.length,
                itemBuilder: (context, i) {
                  final b = DummyData.buildings[i];
                  return GestureDetector(
                    onTap: () => context.go(
                        '/explore?bid=${b.name.substring(0, 1).toUpperCase()}'),
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF3B82F6),
                                AppColors.primaryBlueDark
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.blueShadow,
                                  blurRadius: 15,
                                  offset: const Offset(0, 8))
                            ],
                          ),
                          child: Icon(_buildingIcon(b.icon),
                              size: 24, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          b.name.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate500,
                              letterSpacing: 0.5),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(delay: (700 + i * 50).ms, duration: 300.ms)
                      .scale(begin: const Offset(0.7, 0.7));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _buildingIcon(String name) {
    switch (name) {
      case 'cpu':
        return LucideIcons.cpu;
      case 'bar-chart-3':
        return LucideIcons.barChart3;
      case 'scale':
        return LucideIcons.scale;
      case 'pen-tool':
        return LucideIcons.penTool;
      case 'heart-pulse':
        return LucideIcons.heartPulse;
      case 'beaker':
        return LucideIcons.beaker;
      case 'users-2':
        return LucideIcons.users2;
      case 'palette':
        return LucideIcons.palette;
      default:
        return LucideIcons.building;
    }
  }
}
