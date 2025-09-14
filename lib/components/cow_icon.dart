import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CowIcon extends StatelessWidget {
  final double size;
  final Color color;
  final bool isFilled;

  const CowIcon({
    super.key,
    this.size = 24,
    this.color = AppColors.darkBrown,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: CowIconPainter(
        color: color,
        isFilled: isFilled,
      ),
    );
  }
}

class CowIconPainter extends CustomPainter {
  final Color color;
  final bool isFilled;

  CowIconPainter({
    required this.color,
    required this.isFilled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();

    // Cabeça da vaca (forma oval)
    final headRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.4),
      width: size.width * 0.6,
      height: size.height * 0.5,
    );
    path.addOval(headRect);

    // Orelhas
    final leftEarRect = Rect.fromCenter(
      center: Offset(size.width * 0.25, size.height * 0.25),
      width: size.width * 0.15,
      height: size.height * 0.2,
    );
    path.addOval(leftEarRect);

    final rightEarRect = Rect.fromCenter(
      center: Offset(size.width * 0.75, size.height * 0.25),
      width: size.width * 0.15,
      height: size.height * 0.2,
    );
    path.addOval(rightEarRect);

    // Chifres
    final leftHornPath = Path();
    leftHornPath.moveTo(size.width * 0.3, size.height * 0.2);
    leftHornPath.lineTo(size.width * 0.25, size.height * 0.1);
    leftHornPath.lineTo(size.width * 0.35, size.height * 0.15);

    final rightHornPath = Path();
    rightHornPath.moveTo(size.width * 0.7, size.height * 0.2);
    rightHornPath.lineTo(size.width * 0.75, size.height * 0.1);
    rightHornPath.lineTo(size.width * 0.65, size.height * 0.15);

    // Olhos
    final leftEyeRect = Rect.fromCenter(
      center: Offset(size.width * 0.4, size.height * 0.35),
      width: size.width * 0.08,
      height: size.height * 0.08,
    );
    path.addOval(leftEyeRect);

    final rightEyeRect = Rect.fromCenter(
      center: Offset(size.width * 0.6, size.height * 0.35),
      width: size.width * 0.08,
      height: size.height * 0.08,
    );
    path.addOval(rightEyeRect);

    // Focinho
    final noseRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.5),
      width: size.width * 0.15,
      height: size.height * 0.1,
    );
    path.addOval(noseRect);

    canvas.drawPath(path, paint);

    // Desenhar chifres separadamente
    canvas.drawPath(leftHornPath, paint);
    canvas.drawPath(rightHornPath, paint);

    // Se for preenchido, adicionar pontos para simular manchas
    if (isFilled) {
      final spotPaint = Paint()
        ..color = color.withAlpha(77)
        ..style = PaintingStyle.fill;

      // Manchas na cabeça
      canvas.drawCircle(
        Offset(size.width * 0.35, size.height * 0.45),
        size.width * 0.05,
        spotPaint,
      );
      canvas.drawCircle(
        Offset(size.width * 0.65, size.height * 0.45),
        size.width * 0.05,
        spotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
