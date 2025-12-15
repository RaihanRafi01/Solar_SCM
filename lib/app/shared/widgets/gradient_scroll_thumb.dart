// Add this helper class *outside* the ScmView class, perhaps in its own file
// or just above ScmView in the main file for simplicity.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/themes/app_colors.dart';
// Assuming AppColors is available

class GradientScrollThumb extends StatelessWidget {
  final double thickness;
  final double radius;
  final double height;
  final double totalScrollExtent;
  final double viewportDimension;
  final double currentScrollOffset;

  const GradientScrollThumb({
    super.key,
    required this.thickness,
    required this.radius,
    required this.height,
    required this.totalScrollExtent,
    required this.viewportDimension,
    required this.currentScrollOffset,
  });

  @override
  Widget build(BuildContext context) {
    // If the list isn't scrollable, hide the thumb (maxScrollExtent <= 0)
    if (totalScrollExtent <= 0) {
      return const SizedBox.shrink();
    }

    // Calculate the thumb height: (visible_area / total_content_area) * container_height
    final double thumbHeight =
        (viewportDimension / (totalScrollExtent + viewportDimension)) * height;

    // Calculate the thumb position: (current_scroll / max_scroll_distance) * (track_height - thumb_height)
    final double scrollFraction = currentScrollOffset / totalScrollExtent;
    final double thumbPosition = scrollFraction * (height - thumbHeight);

    return Positioned(
      // Position to the right, adjacent to the ListView
      right: 0,
      top: thumbPosition,
      child: Container(
        width: thickness,
        // Ensure thumb has a minimum size
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            // Optional: for a subtle lift effect
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
          // Apply the Gradient
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.textHint,
              AppColors.appColor2, // Use a secondary color for the gradient
            ],
          ),
        ),
      ),
    );
  }
}