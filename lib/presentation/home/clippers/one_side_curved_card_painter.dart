import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill;


    Path path_0 = Path();
    path_0.moveTo(0,size.height*0.1176471);
    path_0.quadraticBezierTo(size.width*0.0020313,size.height*-0.0037647,size.width*0.0656250,0);
    path_0.lineTo(size.width*0.8781250,size.height*0.0058824);
    path_0.quadraticBezierTo(size.width*0.9323125,size.height*-0.0032941,size.width*0.9343750,size.height*0.1058824);
    path_0.quadraticBezierTo(size.width*0.9352422,size.height*0.1978971,size.width*0.9366250,size.height*0.3828235);
    path_0.quadraticBezierTo(size.width*0.9380937,size.height*0.4910000,size.width*0.8831875,size.height*0.4395882);
    path_0.cubicTo(size.width*0.6904062,size.height*0.3660588,size.width*0.6970312,size.height*0.7288824,size.width*0.7591875,size.height*0.8015294);
    path_0.quadraticBezierTo(size.width*0.7831562,size.height*0.8501176,size.width*0.7505937,size.height*0.8832353);
    path_0.lineTo(size.width*0.4223750,size.height*0.8819412);
    path_0.quadraticBezierTo(size.width*0.1501250,size.height*0.8822500,size.width*0.0593750,size.height*0.8823529);
    path_0.quadraticBezierTo(size.width*-0.0019375,size.height*0.8797059,size.width*0.0031250,size.height*0.7647059);
    path_0.quadraticBezierTo(size.width*0.0023437,size.height*0.6029412,0,size.height*0.1176471);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);





  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

class OneSideCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.1176471);
    path.quadraticBezierTo(size.width * 0.0020313, size.height * -0.0037647, size.width * 0.0656250, 0);
    path.lineTo(size.width * 0.8781250, size.height * 0.0058824);
    path.quadraticBezierTo(size.width * 0.9323125, size.height * -0.0032941, size.width * 0.9343750, size.height * 0.1058824);
    path.quadraticBezierTo(size.width * 0.9352422, size.height * 0.1978971, size.width * 0.9366250, size.height * 0.3828235);
    path.quadraticBezierTo(size.width * 0.9380937, size.height * 0.4910000, size.width * 0.8831875, size.height * 0.4395882);
    path.cubicTo(size.width * 0.6904062, size.height * 0.3660588, size.width * 0.6970312, size.height * 0.7288824, size.width * 0.7591875, size.height * 0.8015294);
    path.quadraticBezierTo(size.width * 0.7831562, size.height * 0.8501176, size.width * 0.7505937, size.height * 0.8832353);
    path.lineTo(size.width * 0.4223750, size.height * 0.8819412);
    path.quadraticBezierTo(size.width * 0.1501250, size.height * 0.8822500, size.width * 0.0593750, size.height * 0.8823529);
    path.quadraticBezierTo(size.width * -0.0019375, size.height * 0.8797059, size.width * 0.0031250, size.height * 0.7647059);
    path.quadraticBezierTo(size.width * 0.0023437, size.height * 0.6029412, 0, size.height * 0.1176471);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

