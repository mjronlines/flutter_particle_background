library flutter_particle_bg;

import 'dart:math';

import 'package:flutter/material.dart';

class MooooooBackground extends StatelessWidget {
  final Widget child;
  final double pointsize; // 点大小
  final Color pointcolor; // 点颜色
  final double linewidth; // 线宽度
  final Color linecolor; // 线颜色
  final double pointnumber; // 圆点数量
  final double distancefar; //划线距离
  final Color backgroundcolor; // 粒子位置背景
  final double pointspeed; // 粒子运行速度
  MooooooBackground(
      {this.child,
      this.pointsize = 4.0,
      this.pointcolor = Colors.red,
      this.linewidth = 0.5,
      this.linecolor = Colors.red,
      this.pointnumber = 20,
      this.distancefar = 120.0,
      this.backgroundcolor = Colors.white,
      this.pointspeed = 0.8});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Backgroundparticle(
          backgroundcolor: backgroundcolor,
          pointcolor: pointcolor,
          pointnumber: pointnumber,
          pointsize: pointsize,
          linecolor: linecolor,
          linewidth: linewidth,
          distancefar: distancefar,
          pointspeed: pointspeed,
        ),
        child,
      ],
    );
  }
}

class Pointvector {
  double x;
  double y;
  double x1;
  double y1;
  bool vx;
  bool vy;

  Pointvector({this.x, this.y, this.vx, this.vy, this.x1, this.y1});
}

class Backgroundparticle extends StatefulWidget {
  final double pointsize; // 点大小
  final Color pointcolor; // 点颜色
  final double linewidth; // 线宽度
  final Color linecolor; // 线颜色
  final double pointnumber; // 圆点数量
  final double distancefar; //划线距离
  final Color backgroundcolor; // 粒子位置背景
  final double pointspeed; // 粒子运行速度
  Backgroundparticle(
      {this.pointsize = 4.0,
      this.pointcolor = Colors.red,
      this.linewidth = 0.5,
      this.linecolor = Colors.red,
      this.pointnumber = 20,
      this.distancefar = 120.0,
      this.backgroundcolor = Colors.white,
      this.pointspeed = 0.8});

  @override
  _BackgroundparticleState createState() => _BackgroundparticleState();
}

class _BackgroundparticleState extends State<Backgroundparticle>
    with TickerProviderStateMixin {
  AnimationController animationDemoController;
  Animation animation;
  List<Pointvector> pointList;
  List<Pointvector> linespoint;
  List<Map> linespoint2;
  List<int> linespointindex;
  Random rd;

  @override
  void initState() {
    super.initState();
    rd = new Random();
    animationDemoController = AnimationController(
        lowerBound: 30,
        upperBound: 50,
        duration: Duration(milliseconds: 20000),
        vsync: this);
    animation = Tween(begin: 1, end: 200).animate(animationDemoController);
    animationDemoController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          animationDemoController.reverse();
          break;
        case AnimationStatus.dismissed:
          animationDemoController.forward();
          break;
        default:
          break;
      }
    });

    Future.delayed(Duration.zero, () {
      BuildContext ct = this.context;
      Size size = MediaQuery.of(ct).size;
      animationDemoController.addListener(() {
        this.initPointList(size);
      });
      animationDemoController.forward();
    });
  }

  initPointList(Size size) {
    if (pointList == null) {
      pointList = new List<Pointvector>();
      linespoint = new List<Pointvector>();

      for (var i = 0; i < this.widget.pointnumber; i++) {
        Pointvector pointvector = new Pointvector();
        pointvector.x = rd.nextInt(size.width.toInt() - 1).toDouble();
        pointvector.y = rd.nextInt(size.height.toInt() - 1).toDouble();
        pointvector.vx = rd.nextInt(10) > 5 ? true : false;
        pointvector.vy = rd.nextInt(10) > 5 ? true : false;
        pointList.add(pointvector);
      }
    }

    for (var i = 0; i < pointList.length; i++) {
      double x = this.widget.pointspeed;
      double y = this.widget.pointspeed;
      if (pointList[i].x + x > (size.width - 2)) {
        pointList[i].vx = false;
      }

      if (pointList[i].x < 10) {
        pointList[i].vx = true;
      }

      pointList[i].x =
          pointList[i].vx ? pointList[i].x + x : pointList[i].x - x;

      if (pointList[i].y + y > (size.height - 100)) {
        pointList[i].vy = false;
      }

      if (pointList[i].y < 10) {
        pointList[i].vy = true;
      }

      pointList[i].y =
          pointList[i].vy ? pointList[i].y + y : pointList[i].y - y;
    }
    linespoint.removeRange(0, linespoint.length);

    for (int i = 0; i < pointList.length; i++) {
      for (int j = i + 1; j < pointList.length; j++) {
        double _len = PointFormat.distanceTo(
            pointList[i].x, pointList[i].y, pointList[j].x, pointList[j].y);

        if (_len < this.widget.distancefar) {
          Pointvector p = new Pointvector(
              x: pointList[i].x,
              y: pointList[i].y,
              x1: pointList[j].x,
              y1: pointList[j].y);

          linespoint.add(p);
        }
      }
    }

    setState(() {
      pointList = pointList;
      linespoint = linespoint;
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationDemoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        top: 0,
        child: Container(
            color: this.widget.backgroundcolor,
            child: pointList != null
                ? CustomPaint(
                    painter: PaintAnimationPoint(
                        pointList: pointList,
                        linespoint: linespoint,
                        pointcolor: this.widget.pointcolor,
                        pointsize: this.widget.pointsize,
                        linecolor: this.widget.linecolor,
                        linewidth: this.widget.linewidth),
                  )
                : null));
  }
}

class PaintAnimationPoint extends CustomPainter {
  final List<Pointvector> pointList;
  final List<Pointvector> linespoint;
  final double pointsize;
  final Color pointcolor;
  final double linewidth;
  final Color linecolor;

  PaintAnimationPoint(
      {this.pointList,
      this.linespoint,
      this.pointsize,
      this.pointcolor,
      this.linewidth,
      this.linecolor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = pointsize
      ..color = pointcolor;
    for (var i = 0; i < pointList.length; i++) {
      Pointvector p = pointList[i];
      canvas.drawLine(Offset(p.x, p.y), Offset(p.x, p.y),
          paint..strokeCap = StrokeCap.round);
    }
    paint.strokeWidth = linewidth;
    paint.color = linecolor;

    if (linespoint != null) {
      for (var i = 0; i < linespoint.length; i++) {
        Pointvector p = linespoint[i];
        canvas.drawLine(Offset(p.x, p.y), Offset(p.x1, p.y1),
            paint..strokeCap = StrokeCap.round);
      }
    }
  }

  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PointFormat {
  static distanceTo(double x, double y, double dx1, double dy1) {
    var dx = x - dx1;
    var dy = y - dy1;
    return sqrt(dx * dx + dy * dy);
  }
}
