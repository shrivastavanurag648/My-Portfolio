import 'dart:math' as math;
import 'package:flutter/material.dart';

class AntigravityWidget extends StatefulWidget {
  const AntigravityWidget({
    required this.child,
    super.key,
    this.floatDistance = 15.0,
    this.rotationDegrees = 2.0,
    this.duration = const Duration(seconds: 4),
  });

  final Widget child;
  final double floatDistance;
  final double rotationDegrees;
  final Duration duration;

  @override
  State<AntigravityWidget> createState() => _AntigravityWidgetState();
}

class _AntigravityWidgetState extends State<AntigravityWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // Customize the Flutter AnimationController for the Antigravity widget
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Movement using Curves.easeInOutSine to make floating natural and fluid
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );

    _floatAnimation = Tween<double>(
      begin: -widget.floatDistance,
      end: widget.floatDistance,
    ).animate(curvedAnimation);

    // RotationTransition of 1-2 degrees so it tilts as it floats
    // We convert degrees to radians: (degrees * pi) / 180
    final maxRadians = (widget.rotationDegrees * math.pi) / 180;
    _rotationAnimation = Tween<double>(
      begin: -maxRadians,
      end: maxRadians,
    ).animate(curvedAnimation);

    // Repeat the animation drifting back and forth
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: child,
          ),
        ),
      child: widget.child,
    );
}
