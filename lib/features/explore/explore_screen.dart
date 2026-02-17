import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../dummy_data.dart';

class ExploreScreen extends StatelessWidget {
  final String? buildingFilter;
  const ExploreScreen({super.key, this.buildingFilter});

  @override
  Widget build(BuildContext context) {
    final rooms = buildingFilter != null
        ? DummyData.popularRooms
            .where((r) => r.buildingId == buildingFilter)
            .toList()
        : DummyData.popularRooms;

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
                'Explore Room',
                style: AppTypography.headingBlack.copyWith(fontSize: 28),
              ).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 24),
              Expanded(
                child: rooms.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.searchX,
                                size: 48, color: AppColors.slate300),
                            const SizedBox(height: 12),
                            const Text(
                              'Tidak ada ruangan ditemukan',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate300),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: rooms.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, i) {
                          final room = rooms[i];
                          return GestureDetector(
                            onTap: () => context.push('/room/${room.id}'),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(color: AppColors.slate100),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.slateShadow,
                                      blurRadius: 4)
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      room.imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        width: 80,
                                        height: 80,
                                        color: AppColors.slate100,
                                        child: const Icon(LucideIcons.image,
                                            color: AppColors.slate300),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                room.name.toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900,
                                                  color: AppColors.slate900,
                                                  letterSpacing: -0.5,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Icon(
                                              LucideIcons.heart,
                                              size: 16,
                                              color: room.isFavorite
                                                  ? AppColors.rose500
                                                  : AppColors.slate200,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          room.building.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.slate400,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(
                                  delay: (200 + i * 80).ms, duration: 300.ms)
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
