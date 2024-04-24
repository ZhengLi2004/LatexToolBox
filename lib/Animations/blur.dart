import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/widgets.dart';

class Blur extends StatefulWidget {
  const Blur({Key? key, required this.theWidth, required this.theHeight, required this.theChild}) : super(key: key);

  final theWidth;
  final theHeight;
  final theChild;

  @override
  State<Blur> createState() => _BlurState();
}

class _BlurState extends State<Blur> {
  @override
  Widget build(BuildContext context) {
      return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: widget.theWidth,
        height: widget.theHeight,
        color: Colors.transparent,
        child: Stack(
          children: [
            //blur effect
            BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: Container(),
            ),
            //gradient effect
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ]
                ),
              ),
            ),
            //child
            Center(child: widget.theChild),
          ],
        ),
      ),
    );
  }
}