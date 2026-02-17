import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../dummy_data.dart';
import '../../models/room.dart';
import '../../shared/widgets/success_toast.dart';

class RoomDetailScreen extends StatefulWidget {
  final int roomId;
  const RoomDetailScreen({super.key, required this.roomId});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  int _selectedDate = 0;
  int _selectedSession = 0;
  bool _isFav = false;

  late Room room;

  final dates = [
    {'day': 'Sen', 'date': '17'},
    {'day': 'Sel', 'date': '18'},
    {'day': 'Rab', 'date': '19'},
    {'day': 'Kam', 'date': '20'},
    {'day': 'Jum', 'date': '21'},
    {'day': 'Sab', 'date': '22'},
  ];

  final sessions = [
    {'id': 1, 'time': '08:00 - 10:00'},
    {'id': 2, 'time': '10:00 - 12:00'},
    {'id': 3, 'time': '13:00 - 15:00'},
    {'id': 4, 'time': '15:00 - 17:00'},
  ];

  @override
  void initState() {
    super.initState();
    room = DummyData.popularRooms.firstWhere(
      (r) => r.id == widget.roomId,
      orElse: () => DummyData.popularRooms.first,
    );
    _isFav = room.isFavorite;
  }

  void _handleBooking() {
    SuccessToast.show(context,
        message: 'Berhasil! ${room.name} telah dipesan.');
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) context.go('/booked');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // —— Hero Image ——
            Stack(
              children: [
                Image.network(
                  room.imageUrl,
                  height: 288,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(height: 288, color: AppColors.slate200),
                ),
                Container(
                  height: 288,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8)
                      ],
                    ),
                  ),
                ),
                // Back + Fav
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _glassBtnWidget(
                          icon: LucideIcons.chevronLeft,
                          onTap: () => context.pop(),
                        ),
                        _glassBtnWidget(
                          icon: LucideIcons.heart,
                          color: _isFav ? AppColors.rose500 : Colors.white,
                          filled: _isFav,
                          onTap: () => setState(() => _isFav = !_isFav),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.emerald500,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    AppColors.emerald500.withValues(alpha: 0.3),
                                blurRadius: 12)
                          ],
                        ),
                        child: const Text(
                          'TERSEDIA',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        room.name,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      Text(
                        room.building.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.7)),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // —— Date Picker ——
                  Text('Pilih Tanggal',
                          style:
                              AppTypography.headingBlack.copyWith(fontSize: 18))
                      .animate()
                      .fadeIn(delay: 200.ms),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        final isActive = _selectedDate == i;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDate = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 70,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.blue600
                                  : AppColors.slate50,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                  color: isActive
                                      ? AppColors.blue600
                                      : AppColors.slate100),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dates[i]['day']!,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: isActive
                                        ? Colors.white.withValues(alpha: 0.6)
                                        : AppColors.slate400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  dates[i]['date']!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: isActive
                                        ? Colors.white
                                        : AppColors.slate900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(delay: (300 + i * 50).ms);
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // —— Session Picker ——
                  Text('Pilih Sesi',
                          style:
                              AppTypography.headingBlack.copyWith(fontSize: 18))
                      .animate()
                      .fadeIn(delay: 500.ms),

                  const SizedBox(height: 16),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 2.2,
                    ),
                    itemCount: sessions.length,
                    itemBuilder: (context, i) {
                      final isActive = _selectedSession == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSession = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color:
                                isActive ? AppColors.slate800 : AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isActive
                                  ? AppColors.slate800
                                  : AppColors.slate100,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SESI ${sessions[i]['id']}',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                  color: isActive
                                      ? Colors.white.withValues(alpha: 0.5)
                                      : AppColors.slate400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                sessions[i]['time'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: isActive
                                      ? Colors.white
                                      : AppColors.slate900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: (600 + i * 60).ms);
                    },
                  ),

                  const SizedBox(height: 40),

                  // —— Validation + Book Button ——
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: AppColors.slate100),
                      boxShadow: [
                        BoxShadow(color: AppColors.slateShadow, blurRadius: 8)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'STATUS VALIDASI',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate400,
                                  letterSpacing: 2),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.emerald500,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'BEBAS KONFLIK',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.emerald600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _handleBooking,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 8,
                            shadowColor: AppColors.blue200,
                          ),
                          child: const Text(
                            'Pesan Sekarang',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassBtnWidget({
    required IconData icon,
    Color color = Colors.white,
    bool filled = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, size: 24, color: color),
      ),
    );
  }
}
