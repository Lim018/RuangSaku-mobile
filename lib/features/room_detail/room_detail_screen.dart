import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../dummy_data.dart';
import '../../shared/widgets/booking_bottom_sheet.dart';
import '../../shared/widgets/success_toast.dart';

class RoomDetailScreen extends StatefulWidget {
  final int roomId;
  const RoomDetailScreen({super.key, required this.roomId});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  int _selectedDateIndex = 0;
  int _selectedSlotIndex = 0;

  final _dates = [
    {'day': 'ISN', 'date': '17'},
    {'day': 'SEL', 'date': '18'},
    {'day': 'RAB', 'date': '19'},
    {'day': 'KHA', 'date': '20'},
  ];

  final _slots = [
    {'label': 'Pagi', 'time': '08:00 - 10:00'},
    {'label': 'Tengahari', 'time': '11:00 - 13:00'},
  ];

  @override
  Widget build(BuildContext context) {
    final room = DummyData.popularRooms.firstWhere(
      (r) => r.id == widget.roomId,
      orElse: () => DummyData.popularRooms.first,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: Image.network(
                      room.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.slate200,
                        child: const Icon(LucideIcons.image, size: 48),
                      ),
                    ),
                  ),
                ),
                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        stops: const [0.3, 1.0],
                      ),
                    ),
                  ),
                ),
                // Back button
                Positioned(
                  top: 48,
                  left: 24,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Icon(
                        LucideIcons.chevronLeft,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideX(begin: -0.3, curve: Curves.easeOutCubic),
                // Title overlay
                Positioned(
                  bottom: 40,
                  left: 32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // Pulsing green dot
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4ADE80),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4ADE80)
                                      .withValues(alpha: 0.7),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            room.building.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Colors.white.withValues(alpha: 0.7),
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms, delay: 200.ms)
                    .slideY(begin: 0.2, curve: Curves.easeOutCubic),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Selector
                  const Text(
                    'Pilih Tarikh',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate900,
                      letterSpacing: -0.3,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 300.ms)
                      .slideY(begin: 0.15, curve: Curves.easeOutCubic),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 96,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _dates.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final isActive = index == _selectedDateIndex;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedDateIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 75,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.slate900
                                  : AppColors.slate50,
                              borderRadius: BorderRadius.circular(30),
                              border: isActive
                                  ? null
                                  : Border.all(color: AppColors.slate100),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: AppColors.slate200,
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _dates[index]['day']!,
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    color: isActive
                                        ? Colors.white.withValues(alpha: 0.6)
                                        : AppColors.slate400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _dates[index]['date']!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: isActive
                                        ? Colors.white
                                        : AppColors.slate400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 400.ms)
                      .slideY(begin: 0.15, curve: Curves.easeOutCubic),

                  const SizedBox(height: 32),

                  // Time Slots
                  const Text(
                    'Slot Masa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.slate900,
                      letterSpacing: -0.3,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 500.ms)
                      .slideY(begin: 0.15, curve: Curves.easeOutCubic),
                  const SizedBox(height: 16),
                  Row(
                    children: List.generate(_slots.length, (index) {
                      final isActive = index == _selectedSlotIndex;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedSlotIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.only(right: index == 0 ? 16 : 0),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.slate900
                                  : AppColors.slate50,
                              borderRadius: BorderRadius.circular(16),
                              border: isActive
                                  ? null
                                  : Border.all(color: AppColors.slate100),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: AppColors.slate200,
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _slots[index]['label']!.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900,
                                    color: isActive
                                        ? Colors.white.withValues(alpha: 0.4)
                                        : AppColors.slate400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _slots[index]['time']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: isActive
                                        ? Colors.white
                                        : AppColors.slate700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 600.ms)
                      .slideY(begin: 0.15, curve: Curves.easeOutCubic),

                  const SizedBox(height: 40),

                  // CTA
                  GestureDetector(
                    onTap: () => _handleBooking(room.name),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColors.slate900,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.slate200,
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Tempah Sekarang',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 700.ms)
                      .slideY(begin: 0.2, curve: Curves.easeOutCubic),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBooking(String roomName) async {
    final dateText = '${_dates[_selectedDateIndex]['date']} Feb';
    final timeText = _slots[_selectedSlotIndex]['time']!;
    final dateTime = '$dateText • $timeText';

    final confirmed = await BookingBottomSheet.show(
      context,
      roomName: roomName,
      dateTime: dateTime,
    );

    if (confirmed == true && mounted) {
      SuccessToast.show(context, message: 'Tempahan disahkan!');
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) context.go('/schedule');
    }
  }
}
