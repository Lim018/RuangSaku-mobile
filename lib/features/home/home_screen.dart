import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../../dummy_data.dart';
import 'widgets/home_header.dart';
import 'widgets/room_card.dart';
import 'widgets/building_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Yellow Header Curve
          const HomeHeader(),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section: Rekomendasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rekomendasi', style: AppTypography.headingLG),
                    Row(
                      children: [
                        Text(
                          'Filter',
                          style: AppTypography.bodyXS.copyWith(
                            color: AppColors.indigo600,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(LucideIcons.slidersHorizontal,
                            size: 12, color: AppColors.indigo600),
                      ],
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 500.ms, delay: 200.ms)
                    .slideY(begin: 0.15, curve: Curves.easeOutCubic),

                const SizedBox(height: 20),

                // Horizontal scroll room cards
                SizedBox(
                  height: 270,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    clipBehavior: Clip.none,
                    itemCount: DummyData.popularRooms.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final room = DummyData.popularRooms[index];
                      return RoomCard(
                        room: room,
                        index: index,
                        onTap: () => context.push('/room/${room.id}'),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // Section: Gedung Utama
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Gedung Utama',
                      style: AppTypography.headingLG.copyWith(letterSpacing: -0.3),
                    ),
                    Icon(LucideIcons.layoutGrid, size: 20, color: AppColors.slate300),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 500.ms, delay: 400.ms)
                    .slideY(begin: 0.15, curve: Curves.easeOutCubic),

                const SizedBox(height: 20),

                // Building grid 2x2
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: DummyData.buildings.length,
                  itemBuilder: (context, index) {
                    return BuildingCard(
                      building: DummyData.buildings[index],
                      index: index,
                    );
                  },
                ),

                // Extra bottom padding for nav bar
                const SizedBox(height: AppConstants.navBarHeight + 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
