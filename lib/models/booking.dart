import 'package:flutter/material.dart';

class Booking {
  final String room;
  final String time;
  final String date;
  final String month;
  final String status; // 'Aktif' | 'Akan Datang' | 'Selesai'
  final Color statusColor;
  final Color statusBgColor;

  const Booking({
    required this.room,
    required this.time,
    required this.date,
    required this.month,
    this.status = 'Aktif',
    this.statusColor = const Color(0xFF10B981),
    this.statusBgColor = const Color(0xFFECFDF5),
  });
}
