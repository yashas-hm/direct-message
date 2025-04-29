import 'dart:math';

import 'package:flutter/material.dart';

class ChatPrompterAnimation extends StatefulWidget {
  const ChatPrompterAnimation(
      {super.key, required this.size, required this.lavaCount, this.color});

  final Size size;
  final int lavaCount;
  final Color? color;
  @override
  State<ChatPrompterAnimation> createState() => _ChatPrompterAnimationState();
}

class _ChatPrompterAnimationState extends State<ChatPrompterAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animCtr;
  late final Lava lava;

  @override
  void initState() {
    super.initState();
    lava = Lava(widget.lavaCount);
    animCtr = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    animCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animCtr,
      builder: (_, __) {
        return CustomPaint(
          size: widget.size,
          painter: LavaPainter(
            lava: lava,
            color: widget.color??Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}

class LavaPainter extends CustomPainter {
  final Lava lava;
  final Color color;

  LavaPainter({required this.lava, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (lava.size != size) lava.updateSize(size);
    lava.draw(canvas, size, color);
  }

  @override
  bool shouldRepaint(LavaPainter oldDelegate) => true;
}

class Lava {
  final int ballsCount;
  final num step = 5;
  Size size = Size.zero;
  late Rect sRect;

  double get width => size.width;

  double get height => size.height;

  double get sx => (width ~/ step).toDouble();

  double get sy => (height ~/ step).toDouble();

  bool isPainting = false;
  double iteration = 0;
  int sign = 1;

  final List<Ball> balls = [];
  Map<int, Map<int, ForcePoint<double>>> matrix = {};

  Lava(this.ballsCount);

  void updateSize(Size newSize) {
    size = newSize;
    sRect = Rect.fromCenter(
      center: Offset.zero,
      width: sx,
      height: sy,
    );

    matrix.clear();
    for (int i = (sRect.left - step).toInt(); i < sRect.right + step; i++) {
      matrix[i] = {};
      for (int j = (sRect.top - step).toInt(); j < sRect.bottom + step; j++) {
        matrix[i]?[j] = ForcePoint(
          ((i + sx ~/ 2) * step).toDouble(),
          ((j + sy ~/ 2) * step).toDouble(),
        );
      }
    }

    balls.clear();
    for (int i = 0; i < ballsCount; i++) {
      balls.add(Ball(size));
    }
  }

  double computeForce(int sx, int sy) {
    if (!sRect.contains(Offset(sx.toDouble(), sy.toDouble()))) {
      return (matrix[sx]?[sy]?.force = 0.6 * sign)!;
    }

    final point = matrix[sx]![sy]!;
    double force = 0;
    for (final ball in balls) {
      force += ball.size *
          ball.size /
          (-2 * point.x * ball.pos.x -
              2 * point.y * ball.pos.y +
              ball.pos.magnitude +
              point.magnitude);
    }

    force *= sign;
    matrix[sx]![sy]!.force = force;
    return force;
  }

  final List<int> plx = [0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0];
  final List<int> ply = [0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1];
  final List<int> mscases = [0, 3, 0, 3, 1, 3, 0, 3, 2, 2, 0, 2, 1, 1, 0];
  final List<int> ix = [
    1,
    0,
    -1,
    0,
    0,
    1,
    0,
    -1,
    -1,
    0,
    1,
    0,
    0,
    1,
    1,
    0,
    0,
    0,
    1,
    1
  ];

  List<int>? marchingSquares(List<int> params, Path path) {
    int sx = params[0];
    int sy = params[1];
    int? previousDir = params[2];

    if (matrix[sx]?[sy]?.computed == iteration) return null;

    int dir;
    int mscase = 0;

    for (int a = 0; a < 4; a++) {
      final dx = ix[a + 12];
      final dy = ix[a + 16];
      double force = matrix[sx + dx]![sy + dy]!.force;

      if (force.abs() <= 0 ||
          (force > 0 && sign < 0) ||
          (force < 0 && sign > 0)) {
        force = computeForce(sx + dx, sy + dy);
      }

      if (force.abs() > 1) {
        mscase += pow(2, a).toInt();
      }
    }

    if (mscase == 15) return [sx, sy - 1, -1];
    if (mscase == 5) {
      dir = previousDir == 2 ? 3 : 1;
    } else if (mscase == 10) {
      dir = previousDir == 3 ? 0 : 2;
    } else {
      dir = mscases[mscase];
      matrix[sx]![sy]!.computed = iteration;
    }

    final dx1 = plx[4 * dir + 2];
    final dy1 = ply[4 * dir + 2];
    final dx2 = plx[4 * dir + 3];
    final dy2 = ply[4 * dir + 3];

    double f1 = matrix[sx + dx1]![sy + dy1]!.force.abs() - 1;
    double f2 = matrix[sx + dx2]![sy + dy2]!.force.abs() - 1;

    double p = step / ((f1.abs()) / (f2.abs()) + 1);

    final dxX = plx[4 * dir];
    final dyX = ply[4 * dir];
    final dxY = plx[4 * dir + 1];
    final dyY = ply[4 * dir + 1];

    final x = matrix[sx + dxX]![sy + dyX]!.x + ix[dir] * p;
    final y = matrix[sx + dxY]![sy + dyY]!.y + ix[dir + 4] * p;

    if (!isPainting) {
      path.moveTo(x, y);
    } else {
      path.lineTo(x, y);
    }

    isPainting = true;
    return [sx + ix[dir + 4], sy + ix[dir + 8], dir];
  }

  void draw(Canvas canvas, Size size, Color color, {bool debug = false}) {
    for (var ball in balls) {
      ball.moveIn(size);
    }

    iteration++;
    sign = -sign;
    isPainting = false;

    for (var ball in balls) {
      final path = Path();
      List<int>? params = [
        (ball.pos.x / step - sx / 2).round(),
        (ball.pos.y / step - sy / 2).round(),
        -1
      ];

      do {
        params = marchingSquares(params!, path);
      } while (params != null);

      if (isPainting) {
        path.close();
        canvas.drawPath(path, Paint()..color = color);
        isPainting = false;
      }
    }

    if (debug) {
      for (var ball in balls) {
        canvas.drawCircle(
          Offset(ball.pos.x.toDouble(), ball.pos.y.toDouble()),
          ball.size,
          Paint()..color = Colors.black.withValues(alpha: 0.5),
        );
      }

      matrix.forEach((_, row) {
        row.forEach((_, point) {
          canvas.drawCircle(
            Offset(point.x.toDouble(), point.y.toDouble()),
            max(1, min(point.force.abs(), 5)),
            Paint()..color = point.force > 0 ? Colors.blue : Colors.red,
          );
        });
      });
    }
  }
}

class ForcePoint<T extends num> {
  T x, y;
  double force = 0;
  double computed = 0;

  ForcePoint(this.x, this.y);

  T get magnitude => (x * x + y * y) as T;

  ForcePoint<T> add(ForcePoint<T> other) =>
      ForcePoint((x + other.x) as T, (y + other.y) as T);

  ForcePoint<T> copyWith({T? x, T? y}) => ForcePoint(x ?? this.x, y ?? this.y);
}

class Ball {
  late ForcePoint<double> pos;
  late ForcePoint<double> velocity;
  late double size;

  Ball(Size size) {
    final rand = Random();

    double randomVelocity() =>
        (rand.nextBool() ? 1 : -1) * (0.1 + 0.15 * rand.nextDouble());

    velocity = ForcePoint(randomVelocity(), randomVelocity());
    pos = ForcePoint(
        rand.nextDouble() * size.width, rand.nextDouble() * size.height);

    double base = size.shortestSide / 15;
    this.size = base + (rand.nextDouble() * 1.4 + 0.1) * base;
  }

  void moveIn(Size size) {
    if (pos.x >= size.width - this.size) {
      velocity.x = -velocity.x;
      pos.x = size.width - this.size;
    } else if (pos.x <= this.size) {
      velocity.x = -velocity.x;
      pos.x = this.size;
    }

    if (pos.y >= size.height - this.size) {
      velocity.y = -velocity.y;
      pos.y = size.height - this.size;
    } else if (pos.y <= this.size) {
      velocity.y = -velocity.y;
      pos.y = this.size;
    }

    pos = pos.add(velocity);
  }
}
