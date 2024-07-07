// ignore: implementation_imports
import 'package:day_night_themed_switch/src/day_night_painter.dart';
import 'package:flutter/material.dart';

class DayNightSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final FocusNode? focusNode;
  final Duration animationDuration;
  final double? width;
  final double? height;
  const DayNightSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.focusNode,
    this.animationDuration = const Duration(milliseconds: 400),
    this.width,
    this.height,
  });

  @override
  State<DayNightSwitch> createState() => DayNightSwitchState();
}

@visibleForTesting
class DayNightSwitchState extends State<DayNightSwitch>
    with TickerProviderStateMixin {
  late final AnimationController animation;
  bool _value = false;

  bool get value => _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    animation = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      value: _value ? 1.0 : 0.0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DayNightSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value;
      final target = _value ? 1.0 : 0.0;
      animation.value = target;
    }
  }

  @override
  Widget build(BuildContext context) {
    final switchAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return LayoutBuilder(builder: (context, constraints) {
      return Focus(
        focusNode: widget.focusNode,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              if (animation.isAnimating) return;
              if (!_value) {
                await animation.forward();
              } else {
                await animation.reverse();
              }
              setState(() => _value = !value);
              widget.onChanged?.call(_value);
            },
            child: SizedBox(
              width: widget.width??100,
              height: widget.height??50,
              child: CustomPaint(
                painter: DayNightPainter(switchAnimation.value),
              ),
            ),
          ),
        ),
      );
    });
  }
}
