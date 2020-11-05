import 'package:flutter/material.dart';

class Fundo extends CustomPainter {
  double paddingTela;
  Size celular;

  Fundo(this.paddingTela, this.celular);

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(-paddingTela, -9.5, width * 0.44, height - 9.5),
        topRight: Radius.circular(10),
      ),
    );
    mainBackground.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(-paddingTela, height - 19, celular.width, celular.height),
      ),
    );
    paint.color = Color.fromRGBO(17, 0, 119, 1.0);
    canvas.drawPath(mainBackground, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
