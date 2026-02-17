// V2: Building cards are now rendered inline in home_screen.dart
// This file is kept for backward compatibility but is no longer used.
import 'package:flutter/material.dart';
import '../../../models/building.dart';

class BuildingCard extends StatelessWidget {
  final Building building;
  final int index;
  final VoidCallback? onTap;

  const BuildingCard({
    super.key,
    required this.building,
    this.index = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
