// Refactored GradientScrollThumb to handle dragging
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Assuming AppColors is available
import '../../core/themes/app_colors.dart';

class GradientScrollThumb extends StatelessWidget {
  final double thickness;
  final double radius;
  final double trackHeight; // Renamed 'height' for clarity
  final double totalScrollExtent;
  final double viewportDimension;
  final double currentScrollOffset;
  final ScrollController scrollController; // NEW: Pass the controller
  final Color trackColor; // NEW: Track background color

  const GradientScrollThumb({
    super.key,
    required this.thickness,
    required this.radius,
    required this.trackHeight,
    required this.totalScrollExtent,
    required this.viewportDimension,
    required this.currentScrollOffset,
    required this.scrollController,
    this.trackColor = AppColors.borderColor, // Light gray track
  });

  // Calculate the maximum distance the thumb can travel in the track
  double get maxThumbScrollExtent {
    final double thumbHeight = (viewportDimension / (totalScrollExtent + viewportDimension)) * trackHeight;
    return trackHeight - thumbHeight;
  }

  // Calculate the size of the thumb
  double get thumbHeight {
    return (viewportDimension / (totalScrollExtent + viewportDimension)) * trackHeight;
  }

  // Calculate the thumb position
  double get thumbPosition {
    // If scrollExtent is 0 (not scrollable), return 0
    if (totalScrollExtent <= 0) return 0;

    final double scrollFraction = currentScrollOffset / totalScrollExtent;
    return scrollFraction * maxThumbScrollExtent;
  }


  // --- DRAG LOGIC ---
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (totalScrollExtent <= 0) return; // Cannot drag if not scrollable

    // 1. Calculate the new vertical position of the thumb in the track
    double newThumbPosition = thumbPosition + details.primaryDelta!;

    // 2. Clamp the new position within the valid track bounds
    newThumbPosition = newThumbPosition.clamp(0.0, maxThumbScrollExtent);

    // 3. Calculate the corresponding scroll fraction
    final double scrollFraction = newThumbPosition / maxThumbScrollExtent;

    // 4. Calculate the new scroll offset for the ListView
    final double newScrollOffset = scrollFraction * totalScrollExtent;

    // 5. Scroll the list programmatically
    scrollController.jumpTo(newScrollOffset);
  }
  // --- END DRAG LOGIC ---

  @override
  Widget build(BuildContext context) {
    // If the list isn't scrollable, hide the thumb and track
    if (totalScrollExtent <= 0) {
      return const SizedBox.shrink();
    }

    //

    return Positioned(
      right: 0,
      top: 0, // Track starts at the top
      child: Container(
        height: trackHeight, // Height of the track
        width: thickness,
        decoration: BoxDecoration(
          color: trackColor, // Track color
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Stack(
          children: [
            // Custom Thumb positioned within the Track
            Positioned(
              top: thumbPosition,
              child: GestureDetector( // Allow dragging the thumb
                onVerticalDragUpdate: _onVerticalDragUpdate,
                child: Container(
                  width: thickness,
                  // Ensure thumb has a minimum size for dragging
                  height: thumbHeight.clamp(63.h, trackHeight),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    // Apply the Gradient
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.indicatorColor1,
                        AppColors.indicatorColor2,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}