// shared/widgets/gradient_scroll_thumb.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Assuming AppColors is available
import '../../core/themes/app_colors.dart';

class GradientScrollThumb extends StatelessWidget {
  final double thickness;
  final double radius;
  final double trackHeight;
  final double totalScrollExtent;
  final double viewportDimension;
  final double currentScrollOffset;
  final ScrollController scrollController;
  final Color trackColor;

  const GradientScrollThumb({
    super.key,
    required this.thickness,
    required this.radius,
    required this.trackHeight,
    required this.totalScrollExtent,
    required this.viewportDimension,
    required this.currentScrollOffset,
    required this.scrollController,
    this.trackColor = Colors.black12, // Default to visible dark shade for contrast
  });

  double get maxThumbScrollExtent {
    final double thumbHeight = (viewportDimension / (totalScrollExtent + viewportDimension)) * trackHeight;
    return trackHeight - thumbHeight;
  }

  double get thumbHeight {
    return (viewportDimension / (totalScrollExtent + viewportDimension)) * trackHeight;
  }

  double get thumbPosition {
    if (totalScrollExtent <= 0) return 0;
    final double scrollFraction = currentScrollOffset / totalScrollExtent;
    return scrollFraction * maxThumbScrollExtent;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (totalScrollExtent <= 0) return;
    double newThumbPosition = thumbPosition + details.primaryDelta!;
    newThumbPosition = newThumbPosition.clamp(0.0, maxThumbScrollExtent);
    final double scrollFraction = newThumbPosition / maxThumbScrollExtent;
    final double newScrollOffset = scrollFraction * totalScrollExtent;
    scrollController.jumpTo(newScrollOffset);
  }

  @override
  Widget build(BuildContext context) {
    // Hide if not scrollable
    if (totalScrollExtent <= 0) {
      return const SizedBox.shrink();
    }

    // FIX: Only one Positioned widget is used to avoid the runtime error.
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0, // Constrains the track to the full height (listHeight)
      child: Container(
        // The track height is now managed by the parent Positioned
        width: thickness,
        decoration: BoxDecoration(
          color: trackColor, // Ensure this provides good contrast!
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Stack(
          children: [
            // Custom Thumb positioned within the Track
            Positioned(
              top: thumbPosition,
              child: GestureDetector(
                onVerticalDragUpdate: _onVerticalDragUpdate,
                child: Container(
                  width: thickness,
                  // Ensure thumb has a minimum size for dragging
                  height: thumbHeight.clamp(63.h, trackHeight),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
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