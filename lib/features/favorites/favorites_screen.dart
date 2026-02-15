import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../dummy_data.dart';
import '../../models/room.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites =
        DummyData.popularRooms.where((r) => r.isFavorite).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kegemaran',
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
              const SizedBox(height: 32),
              Expanded(
                child: favorites.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.heart,
                                size: 48, color: AppColors.slate300),
                            const SizedBox(height: 16),
                            const Text(
                              'Tiada kegemaran',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.slate400,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: favorites.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 24),
                        itemBuilder: (context, index) {
                          final room = favorites[index];
                          return _FavoriteCard(room: room)
                              .animate()
                              .fadeIn(
                                duration: 500.ms,
                                delay: (100 * index).ms,
                              )
                              .slideY(
                                begin: 0.15,
                                delay: (100 * index).ms,
                                curve: Curves.easeOutCubic,
                              );
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

class _FavoriteCard extends StatelessWidget {
  final Room room;

  const _FavoriteCard({required this.room});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/room/${room.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: AppColors.slate50),
          boxShadow: [
            BoxShadow(
              color: AppColors.slate100,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.network(
                room.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 80,
                  height: 80,
                  color: AppColors.slate100,
                  child:
                      const Icon(LucideIcons.image, color: AppColors.slate400),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate900,
                      height: 1.2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    room.building.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.slate400,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.heart,
              size: 20,
              color: Colors.red.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
