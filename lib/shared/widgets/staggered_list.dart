import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Wraps a list of children with staggered fade+slide-up animations.
class StaggeredList extends StatelessWidget {
  final List<Widget> children;
  final Duration delay;
  final Duration duration;
  final Axis direction;

  const StaggeredList({
    super.key,
    required this.children,
    this.delay = const Duration(milliseconds: 80),
    this.duration = const Duration(milliseconds: 500),
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(children.length, (index) {
        return children[index]
            .animate()
            .fadeIn(
              duration: duration,
              delay: delay * index,
              curve: Curves.easeOutCubic,
            )
            .slideY(
              begin: 0.15,
              end: 0,
              duration: duration,
              delay: delay * index,
              curve: Curves.easeOutCubic,
            );
      }),
    );
  }
}
