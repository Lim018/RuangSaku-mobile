import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class FilterChips extends StatefulWidget {
  final List<String> labels;
  final ValueChanged<int>? onSelected;

  const FilterChips({
    super.key,
    this.labels = const ['Semua', 'Makmal', 'Seminar'],
    this.onSelected,
  });

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: widget.labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isActive = index == _selected;
          return GestureDetector(
            onTap: () {
              setState(() => _selected = index);
              widget.onSelected?.call(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.slate900 : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: isActive ? null : Border.all(color: AppColors.slate100),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.slate900.withValues(alpha: 0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                widget.labels[index].toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: isActive ? Colors.white : AppColors.slate400,
                  letterSpacing: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
