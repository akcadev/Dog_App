import 'package:flutter/cupertino.dart';

class BottomCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height * 1.010000);
    path.lineTo(size.width * 1.003139, size.height * 1.010000);
    path.lineTo(size.width * 1.002632, size.height * 0.9983890);
    path.lineTo(size.width * 0.9658080, size.height * 0.1526080);
    path.cubicTo(
        size.width * 0.9622293,
        size.height * 0.07038070,
        size.width * 0.9432853,
        size.height * 0.01000000,
        size.width * 0.9210667,
        size.height * 0.01000000);
    path.lineTo(size.width * 0.07893227, size.height * 0.01000000);
    path.cubicTo(
        size.width * 0.05671467,
        size.height * 0.01000000,
        size.width * 0.03777120,
        size.height * 0.07038060,
        size.width * 0.03419120,
        size.height * 0.1526070);
    path.lineTo(size.width * -0.002631821, size.height * 0.9983890);
    path.lineTo(size.width * -0.003137360, size.height * 1.010000);
    path.lineTo(0, size.height * 1.010000);
    path.lineTo(size.width, size.height * 1.010000);
    path.close();

    Paint paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.005333333;
    paintStroke.color = const Color(0xffE5E5EA).withOpacity(1.0);
    canvas.drawPath(path, paintStroke);

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = const Color(0xffF2F2F7).withOpacity(1.0);
    canvas.drawPath(path, paintFill);

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffD1D1D6).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.4986667, size.height * 0.2600000,
                size.width * 0.005333333, size.height * 0.2400000),
            bottomRight: Radius.circular(size.width * 0.002666667),
            bottomLeft: Radius.circular(size.width * 0.002666667),
            topLeft: Radius.circular(size.width * 0.002666667),
            topRight: Radius.circular(size.width * 0.002666667)),
        paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height * 1.010000);
    path.lineTo(size.width * 1.003139, size.height * 1.010000);
    path.lineTo(size.width * 1.002632, size.height * 0.9983890);
    path.lineTo(size.width * 0.9658080, size.height * 0.1526080);
    path.cubicTo(
        size.width * 0.9622293,
        size.height * 0.07038070,
        size.width * 0.9432853,
        size.height * 0.01000000,
        size.width * 0.9210667,
        size.height * 0.01000000);
    path.lineTo(size.width * 0.07893227, size.height * 0.01000000);
    path.cubicTo(
        size.width * 0.05671467,
        size.height * 0.01000000,
        size.width * 0.03777120,
        size.height * 0.07038060,
        size.width * 0.03419120,
        size.height * 0.1526070);
    path.lineTo(size.width * -0.002631821, size.height * 0.9983890);
    path.lineTo(size.width * -0.003137360, size.height * 1.010000);
    path.lineTo(0, size.height * 1.010000);
    path.lineTo(size.width, size.height * 1.010000);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomBottomClipper oldClipper) => false;
}
