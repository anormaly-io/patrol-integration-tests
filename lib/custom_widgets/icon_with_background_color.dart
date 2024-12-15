import 'package:flutter/material.dart';

class IconWithBackground extends StatelessWidget {
  final double backgroundMargin;
  final Color backgroundColor;
  final Widget icon;

  const IconWithBackground({
    Key? key,
    required this.backgroundMargin,
    required this.backgroundColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            margin: EdgeInsets.all(backgroundMargin),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
            ),
          ),
        ),
        icon,
      ],
    );
  }
}
