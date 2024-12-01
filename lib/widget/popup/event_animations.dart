import 'dart:ui';
import 'package:flutter/material.dart';

class EventDialogAnimations extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> blurAnimation;
  final Animation<double> opacityAnimation;
  final Widget child;

  const EventDialogAnimations({
    Key? key,
    required this.scaleAnimation,
    required this.blurAnimation,
    required this.opacityAnimation,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: blurAnimation,
      builder: (context, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurAnimation.value,
            sigmaY: blurAnimation.value,
          ),
          child: child,
        );
      },
      child: Center(
        child: FadeTransition(
          opacity: opacityAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        ),
      ),
    );
  }
}
