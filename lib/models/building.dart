import 'package:flutter/material.dart';

class Building {
  final int id;
  final String name;
  final String icon; // String icon name, mapped in UI
  final int roomCount;
  final Color color;

  const Building({
    this.id = 0,
    required this.name,
    required this.icon,
    required this.roomCount,
    this.color = const Color(0xFFDBEAFE),
  });
}
