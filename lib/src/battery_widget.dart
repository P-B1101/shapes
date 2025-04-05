import 'package:flutter/material.dart';

class BatteryWidget extends StatelessWidget {
  final double percent;
  final double size;
  final Map<double, Color> colors;
  final Color? bodyColor;

  BatteryWidget({super.key, required double percent, this.size = 24, this.colors = const {}, this.bodyColor})
    : percent = percent.clamp(.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: _height,
      child: Row(children: [Expanded(child: _mainBody), const SizedBox(width: 1), _headBody]),
    );
  }

  Widget get _mainBody => LayoutBuilder(
    builder:
        (context, constraints) => Container(
          height: _height,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: bodyColor ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: .5), width: 1),
          ),
          alignment: AlignmentDirectional.centerStart,
          clipBehavior: Clip.antiAlias,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
            height: double.infinity,
            width: constraints.maxWidth * percent,
            decoration: BoxDecoration(
              color: _color(context),
              borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(2)),
            ),
            margin: EdgeInsets.all(1),
          ),
        ),
  );

  Widget get _headBody => Builder(
    builder:
        (context) => Container(
          width: 1,
          height: _height * .3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: bodyColor ?? Theme.of(context).colorScheme.onSurface.withValues(alpha: .5),
          ),
        ),
  );

  Color _color(BuildContext context) {
    final keys = colors.keys.toList()..sort();
    for (var i = keys.length - 1; i >= 0; i--) {
      final color = colors[keys[i]]!;
      final value = keys[i];
      if (percent > value) return color;
    }
    return switch (percent) {
      > .7 => Colors.green,
      > .35 => Colors.yellow,
      _ => Colors.red,
    };
  }

  double get _height => size * .48;
}
