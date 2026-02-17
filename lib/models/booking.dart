import 'package:flutter/material.dart';

class Booking {
  final int id;
  final String room;
  final String time;
  final String date;
  final String month;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final int roomId;
  final String session;

  const Booking({
    this.id = 0,
    required this.room,
    required this.time,
    required this.date,
    required this.month,
    this.status = 'Aktif',
    this.statusColor = const Color(0xFF059669),
    this.statusBgColor = const Color(0xFFECFDF5),
    this.roomId = 0,
    this.session = '',
  });
}
