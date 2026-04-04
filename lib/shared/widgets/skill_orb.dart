import 'dart:math' as math;
import 'package:flutter/material.dart';

class SkillOrb extends StatefulWidget {
  const SkillOrb({
    super.key,
    required this.icon,
    required this.label,
    required this.brandColor,
  });

  final Widget icon;
  final String label;
  final Color brandColor;

  @override
  State<SkillOrb> createState() => _SkillOrbState();
}

class _SkillOrbState extends State<SkillOrb> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late Animation<double> _rotationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    final int randomDurationMs = 3500 + math.Random().nextInt(2001); // 3500 to 5500 ms
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: randomDurationMs),
    );

    // Use math.Random() to give each orb a unique starting offset
    final randomOffset = math.Random().nextDouble();
    _controller.value = randomOffset;

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );

    _floatAnimation = Tween<double>(begin: -15.0, end: 15.0).animate(curvedAnimation);
    _rotationAnimation = Tween<double>(begin: -0.01, end: 0.01).animate(curvedAnimation);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Antigravity translation logic wrapped in an AnimatedBuilder
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: Transform.rotate(
              angle: _rotationAnimation.value * 2 * math.pi, // 0.01 turns converted to radians
              child: child,
            ),
          );
        },
        child: AnimatedScale(
          scale: _isHovered ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          // Very subtle RotationTransition of 2 degrees (approx 0.0055 turns) when hovered
          child: AnimatedRotation(
            turns: _isHovered ? (2 / 360) : 0, 
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.brandColor.withOpacity(0.3),
                  width: 1,
                ),
                gradient: RadialGradient(
                  colors: [
                    widget.brandColor.withOpacity(0.2), // Faint version of brandColor in center
                    Colors.transparent,                 // Fading to transparent at edges
                  ],
                  stops: const [0.2, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.brandColor.withOpacity(_isHovered ? 0.6 : 0.3),
                    blurRadius: _isHovered ? 40 : 20,
                    spreadRadius: _isHovered ? 10 : 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icon,
                  const SizedBox(height: 8),
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
