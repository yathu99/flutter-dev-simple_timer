import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(home: SimpleTimer()));

class SimpleTimer extends StatelessWidget {
  SimpleTimer({Key? key}) : super(key: key);

  double base_value = 600;
  double inner_off = 90;
  double angle = pi / 30;



  @override
  Widget build(BuildContext context) {
    Widget barba = Container(
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );

    Widget repta = Container(
      height: base_value,
      decoration: BoxDecoration(
        color: Colors.teal[300],
        shape: BoxShape.circle,
      ),
    );
    Widget pepta = Container(
      height: base_value - inner_off,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );

    return Material(
      color: Colors.black,
      child: Center(
        child: Stack(children: <Widget>[
          Center(child: repta),
          Center(child: pepta),
          for (var i = 0; i < 60; i++) ...[
            Center(child: Tempas(indexPlace: i, bars: barba)),
          ],
          const Center(
              child: Text(
            '17:30',
            style: TextStyle(fontFamily: 'Audio', fontSize: 100),
          )),
        ]),
      ),
    );
  }
}

class Timestamp {
  static int hours = 00;
  static int min = 00;
  static int seconds = 00;
  static double micros = 00.00;

  parse(int hr, int min, int sec, double mic) {
    return hr.toString() + min.toString() + sec.toString() + mic.toString();
  }
}

class Tempas extends StatelessWidget {
  Tempas({Key? key, required this.indexPlace, required this.bars})
      : super(key: key);

  final int indexPlace;
  final Widget? bars;
  double base_value = 600;
  double inner_off = 90;
  double angle = pi / 30;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(
            cos(angle * indexPlace - pi / 2) * (base_value - inner_off / 2) / 2,
            sin(angle * indexPlace - pi / 2) *
                (base_value - inner_off / 2) /
                2),
        child: Transform.rotate(
          angle: angle * indexPlace,
          child: bars,
        ));
  }
}
