import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class Dash extends StatefulWidget {
  const Dash({super.key, required this.dancing});

  final bool dancing;

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  final SimpleAnimation idle = SimpleAnimation('idle');
  late final SimpleAnimation dance = SimpleAnimation(
    'slowDance',
    autoplay: widget.dancing,
  );

  @override
  void didUpdateWidget(covariant Dash oldWidget) {
    super.didUpdateWidget(oldWidget);
    dance.isActive = widget.dancing;
  }

  @override
  void dispose() {
    idle.dispose();
    dance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 80),
      child: Transform.scale(
        scale: 7,
        child: RiveAnimation.asset(
          'assets/images/dash.riv',
          controllers: [
            idle,
            dance,
          ], // idle, lookUp, slowDance
        ),
      ),
    );
  }
}
