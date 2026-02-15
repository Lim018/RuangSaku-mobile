import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../../models/room.dart';
import '../../dummy_data.dart';
import '../../shared/widgets/press_effect.dart';
import '../../shared/widgets/success_toast.dart';
import 'widgets/room_info_chip.dart';
import 'widgets/time_picker_row.dart';

class RoomDetailScreen extends StatelessWidget {
  final int roomId;
  const RoomDetailScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    final room = DummyData.popularRooms.firstWhere(
      (r) => r.id == roomId,
      orElse: () => DummyData.popularRooms.first,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            _buildHeroImage(context, room),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingXL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info chips
                  Row(
                    children: [
                      Expanded(
                        child: RoomInfoChip(
                          icon: LucideIcons.users,
                          iconColor: AppColors.indigo500,
                          label: 'KAPASITAS',
                          value: '${room.capacity} Pax',
                          index: 0,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RoomInfoChip(
                          icon: LucideIcons.airplay,
                          iconColor: AppColors.emerald500,
                          label: 'FASILITAS',
                          value: room.facilities,
                          index: 1,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RoomInfoChip(
                          icon: LucideIcons.wifi,
                          iconColor: AppColors.amber600,
                          label: 'WIFI 6',
                          value: room.wifiSpeed,
                          index: 2,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),

                  // Time Picker Section
                  Text(
                    'Pilih Waktu',
                    style: AppTypography.headingLG,
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 400.ms)
                      .slideY(begin: 0.2, curve: Curves.easeOutCubic),

                  const SizedBox(height: 20),

                  const TimePickerRow()
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 500.ms)
                      .slideY(begin: 0.2, curve: Curves.easeOutCubic),

                  const SizedBox(height: 36),

                  // Confirm button
                  PressEffect(
                    onTap: () {
                      SuccessToast.show(context);
                      Future.delayed(const Duration(milliseconds: 2400), () {
                        if (context.mounted) {
                          context.go('/schedule');
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColors.slate900,
                        borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.slateShadow,
                            blurRadius: 32,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Konfirmasi Sekarang',
                          style: AppTypography.buttonLG,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 600.ms)
                      .slideY(begin: 0.3, curve: Curves.easeOutCubic),

                  const SizedBox(height: AppConstants.navBarHeight + 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context, Room room) {
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(AppConstants.radiusHero),
            bottomRight: Radius.circular(AppConstants.radiusHero),
          ),
          child: Image.network(
            room.imageUrl,
            height: AppConstants.heroImageHeight,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: AppConstants.heroImageHeight,
              color: AppColors.slate200,
            ),
          ),
        ),
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppConstants.radiusHero),
                bottomRight: Radius.circular(AppConstants.radiusHero),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.85),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),
        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 24,
          child: PressEffect(
            onTap: () => context.pop(),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: const Icon(LucideIcons.chevronLeft, color: AppColors.white, size: 24),
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms)
              .scale(begin: const Offset(0.7, 0.7), curve: Curves.easeOutBack),
        ),
        // Room info
        Positioned(
          bottom: 40,
          left: 32,
          right: 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryYellow.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  room.isAvailable ? 'TERSEDIA' : 'TERPAKAI',
                  style: AppTypography.tag,
                ),
              )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 300.ms)
                  .slideX(begin: -0.3, curve: Curves.easeOutCubic),
              const SizedBox(height: 12),
              Text(
                room.name,
                style: AppTypography.headingBlack.copyWith(
                  color: AppColors.white,
                  fontSize: 30,
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 350.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOutCubic),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(LucideIcons.mapPin, size: 12, color: Colors.white.withOpacity(0.7)),
                  const SizedBox(width: 6),
                  Text(
                    room.building,
                    style: AppTypography.bodySM.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 400.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ],
    );
  }
}
