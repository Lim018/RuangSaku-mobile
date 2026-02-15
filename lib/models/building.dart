import 'package:flutter/material.dart';

class Building {
  final String name;
  final IconData icon;
  final int roomCount;
  final Color bgColor;
  final Color iconColor;
  final Color borderColor;

  const Building({
    required this.name,
    required this.icon,
    required this.roomCount,
    required this.bgColor,
    required this.iconColor,
    required this.borderColor,
  });
}
