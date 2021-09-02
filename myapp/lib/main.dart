import 'package:flutter/material.dart';
import 'my-painter.dart';
import 'particle.dart';
import 'dart:math';
import 'package:myapp/particle.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyPainter(),
    );
  }
}

class MyPainter extends StatefulWidget {
  MyPainter({Key? key}) : super(key: key);

  @override
  _MyPainterState createState() => _MyPainterState();

  Color getRandomColor(Random rgn) {
    var a = rgn.nextInt(255);
    var r = rgn.nextInt(255);
    var g = rgn.nextInt(255);
    var b = rgn.nextInt(255);
    return Color.fromARGB(a, r, g, b);
  }
}

double maxRadius = 6;
double maxSpeed = 0.2;
double maxTheta = 2.0 * pi;

class _MyPainterState extends State<MyPainter>
    with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  late Animation<double> animation;
  late AnimationController controller;

  Random rgn = Random(DateTime.now().millisecondsSinceEpoch);

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();

    Color getRandomColor(Random rgn) {
      var a = rgn.nextInt(255);
      var r = rgn.nextInt(255);
      var g = rgn.nextInt(255);
      var b = rgn.nextInt(255);
      return Color.fromARGB(a, r, g, b);
    }

    this.particles = List.generate(100, (index) {
      var p = Particle();
      p.color = getRandomColor(rgn);
      p.position = Offset(-1, -1);
      p.speed = rgn.nextDouble() * maxSpeed;
      p.theta = rgn.nextDouble() * maxTheta;
      p.radius = rgn.nextDouble() * maxRadius;
      return p;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: CustomPaint(
            child: Container(),
            painter: MyPainterCanvas(rgn, particles, animation.value)));
  }
}
