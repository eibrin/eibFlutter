import 'package:flutter/material.dart';
import 'ball.dart';
import 'bar.dart';

class PongLike extends StatefulWidget {
  const PongLike({super.key});

  @override
  State<PongLike> createState() => _PongLikeState();
}

class _PongLikeState extends State<PongLike>
    with SingleTickerProviderStateMixin {
  double width = 0;
  double height = 0;
  double posX = 0;
  double posY = 0;
  double barWidth = 0;
  double barHeight = 0;
  double barPosition = 0;

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    posX = 0;
    posY = 0;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      setState(() {
        posX++;
        posY++;
      });
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        barWidth = width / 5;
        barHeight = height / 20;

        return Stack(
          children: [
            Positioned(
              child: Ball(),
              top: posX,
              left: posY,
            ),
            Positioned(child: Bar(barWidth, barHeight), bottom: 0),
          ],
        );
      }),
    );
  }
}
