// V2: Room cards are now rendered inline in home_screen.dart
// This file is kept for backward compatibility but is no longer used.
import 'package:flutter/material.dart';
import '../../../models/room.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final int index;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.room,
    this.index = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
