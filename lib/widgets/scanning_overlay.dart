// lib/widgets/scanning_overlay.dart
//
// A reusable "scanning" overlay to place on top of a captured image while
// it's being analyzed. Shows a glowing horizontal line that sweeps up and
// down, plus four corner brackets, similar to a barcode/QR scanner UI.

import 'package:flutter/material.dart';

class ScanningOverlay extends StatefulWidget {
  const ScanningOverlay({
    super.key,
    this.lineColor = const Color(0xFF60AD5E), // matches your app's green
    this.duration = const Duration(seconds: 2),
    this.showCorners = true,
    this.cornerColor = Colors.white,
    this.borderRadius = 16,
  });

  final Color lineColor;
  final Duration duration;
  final bool showCorners;
  final Color cornerColor;
  final double borderRadius;

  @override
  State<ScanningOverlay> createState() => _ScanningOverlayState();
}

class _ScanningOverlayState extends State<ScanningOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // The moving scan line. Align maps 0..1 to top..bottom, so no
          // Positioned / LayoutBuilder is needed.
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Align(
                alignment: Alignment(0, _controller.value * 2 - 1),
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: widget.lineColor.withValues(alpha: 0.9),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        widget.lineColor.withValues(alpha: 0.0),
                        widget.lineColor,
                        widget.lineColor.withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),

          // Corner brackets, like a scanner viewfinder.
          if (widget.showCorners) ...[
            Positioned(top: 12, left: 12, child: _corner(topLeft: true)),
            Positioned(top: 12, right: 12, child: _corner(topRight: true)),
            Positioned(bottom: 12, left: 12, child: _corner(bottomLeft: true)),
            Positioned(bottom: 12, right: 12, child: _corner(bottomRight: true)),
          ],
        ],
      ),
    );
  }

  Widget _corner({
    bool topLeft = false,
    bool topRight = false,
    bool bottomLeft = false,
    bool bottomRight = false,
  }) {
    const double size = 24;
    const double thickness = 3;
    final border = BorderSide(color: widget.cornerColor, width: thickness);

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: (topLeft || topRight) ? border : BorderSide.none,
            bottom: (bottomLeft || bottomRight) ? border : BorderSide.none,
            left: (topLeft || bottomLeft) ? border : BorderSide.none,
            right: (topRight || bottomRight) ? border : BorderSide.none,
          ),
        ),
      ),
    );
  }
}