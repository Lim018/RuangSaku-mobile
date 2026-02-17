import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../dummy_data.dart';

class BookedDetailScreen extends StatelessWidget {
  final int bookingId;
  const BookedDetailScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final booking = DummyData.myBookings.firstWhere(
      (b) => b.id == bookingId,
      orElse: () => DummyData.myBookings.first,
    );

    final room = DummyData.popularRooms.firstWhere(
      (r) => r.id == booking.roomId,
      orElse: () => DummyData.popularRooms.first,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // —— Hero Image ——
            Stack(
              children: [
                Image.network(
                  room.imageUrl,
                  height: 256,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(height: 256, color: AppColors.slate200),
                ),
                Container(
                  height: 256,
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
                // Back button
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3)),
                        ),
                        child: const Icon(LucideIcons.chevronLeft,
                            size: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // Info
                Positioned(
                  bottom: 24,
                  left: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.blue600,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.blue600.withValues(alpha: 0.3),
                                blurRadius: 12)
                          ],
                        ),
                        child: const Text(
                          'DIPESAN',
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
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms),

            // —— Reservation Summary ——
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: AppColors.slate100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'RINGKASAN RESERVASI',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: AppColors.slate400,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _infoRow(
                            'Tanggal', '${booking.date} ${booking.month} 2026'),
                        const SizedBox(height: 16),
                        _infoRow('Sesi', booking.session),
                        const SizedBox(height: 16),
                        const Divider(color: AppColors.slate200),
                        const SizedBox(height: 16),
                        _infoRow(
                          'ID Pesanan',
                          'RS-${booking.id}',
                          valueColor: AppColors.blue600,
                          isMonospace: true,
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 400.ms)
                      .slideY(begin: 0.1),

                  const SizedBox(height: 40),

                  // Cancel button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () => _showCancelDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.rose50,
                        foregroundColor: AppColors.rose600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                          side: const BorderSide(color: AppColors.rose100),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(LucideIcons.trash2, size: 20),
                      label: const Text(
                        'Batalkan Booking',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value,
      {Color? valueColor, bool isMonospace = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.slate500),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: valueColor ?? AppColors.slate900,
            fontFamily: isMonospace ? 'monospace' : null,
            letterSpacing: isMonospace ? -0.5 : 0,
          ),
        ),
      ],
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Batalkan Booking',
            style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text('Apakah Anda yakin ingin membatalkan pesanan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tidak',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go('/booked');
            },
            child: const Text('Ya, Batalkan',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: AppColors.rose600)),
          ),
        ],
      ),
    );
  }
}
