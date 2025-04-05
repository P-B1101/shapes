import 'package:flutter/material.dart';

class AntennaWidget extends StatelessWidget {
  final double percent;
  final double size;
  final Color? color;

  AntennaWidget({super.key, required double percent, this.size = 26, this.color}) : percent = percent.clamp(.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: _height,
      child: Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          4,
          (index) => Expanded(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 1), child: _Column(color, _isActive(index), index)),
          ),
        ),
      ),
    );
  }

  double get _height => size * .5;

  bool _isActive(int index) => switch (index) {
    0 => percent >= .25,
    1 => percent >= .5,
    2 => percent >= .75,
    _ => percent >= 1,
  };
}

class _Column extends StatelessWidget {
  final bool isActive;
  final int index;
  final Color? color;
  const _Column(this.color, this.isActive, this.index);

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).colorScheme.onSurface;
    return LayoutBuilder(
      builder:
          (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight * _heightPercent,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(1), color: color.withValues(alpha: .25)),
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.antiAlias,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
              width: constraints.maxWidth,
              height: isActive ? constraints.maxHeight : 0,
              color: color,
              alignment: Alignment.bottomCenter,
            ),
          ),
    );
  }

  double get _heightPercent => switch (index) {
    0 => .4,
    1 => .6,
    2 => .8,
    _ => 1,
  };
}
