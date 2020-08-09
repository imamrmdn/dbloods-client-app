part of '../widgets.dart';

class LineDash extends StatelessWidget {
  final double height;
  final Color color;

  LineDash({this.height = 2, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class LineDash2 extends StatelessWidget {
  final EdgeInsetsGeometry margin;

  LineDash2({this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 2,
      width: SizeConfig.defaultWidth,
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: borderRadius8,
      ),
    );
  }
}
