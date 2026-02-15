import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../dummy_data.dart';
import 'widgets/home_header.dart';
import 'widgets/filter_chips.dart';
import 'widgets/schedule_preview_card.dart';
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
          const HomeHeader(),
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter Chips
                const FilterChips()
                    .animate()
                    .fadeIn(duration: 500.ms, delay: 200.ms)
                    .slideY(begin: 0.15, curve: Curves.easeOutCubic),

                const SizedBox(height: 28),

                // Schedule Preview
                SchedulePreviewCard(
                  onViewAll: () => context.go('/schedule'),
                )
                    .animate()
                    .fadeIn(duration: 500.ms, delay: 300.ms)
                    .slideY(begin: 0.15, curve: Curves.easeOutCubic),

                const SizedBox(height: 28),

                // Gedung Utama Title
                const Text(
                  'Gedung Utama',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColors.slate900,
                    letterSpacing: -0.3,
                  ),
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

                const SizedBox(height: AppConstants.navBarHeight + 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
