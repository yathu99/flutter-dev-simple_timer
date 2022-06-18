import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter/flutter_colorpicker';
import 'dart:math';

void main() => runApp(MaterialApp(home: SimpleTimer()));

class SimpleTimer extends StatefulWidget {
  SimpleTimer({Key? key}) : super(key: key);

  State<SimpleTimer> createState() => _SimpleTimerState();
}

class _SimpleTimerState extends State<SimpleTimer> {
  double baseValue = 300;
  double innerOffset = 50;
  double angle = pi / 30;
  double angle2 = pi / 12;
  Color style1 = Colors.amber;

  DateTime pol = DateTime.now();

  late Timer _timer;
  int hour = 0;
  int minute = 0;
  int totalSec = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          pol = DateTime.now();
          totalSec = 60 - pol.second;
          if (totalSec == 59) {
            setMinute();
          }
        });
      },
    );
  }

  void setMinute() {
    setState(() {
      minute = pol.minute;
      hour = pol.hour;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    Widget barba = Container(
      height: 10,
      width: 5,
      decoration: const BoxDecoration(
        color: Colors.white,
//shape: BoxShape.circle,
      ),
    );
    Widget barbaw = Container(
      height: 10,
      width: 8,
      decoration: const BoxDecoration(
        color: Colors.black,
//shape: BoxShape.circle,
      ),
    );
    Widget sarbaw = Container(
      height: 12,
      decoration: BoxDecoration(
        color: Colors.lightBlue[900],
        shape: BoxShape.circle,
      ),
    );

    Widget repta = Container(
      height: baseValue,
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        shape: BoxShape.circle,
      ),
    );
    Widget pepta = Container(
      height: baseValue - innerOffset,
      decoration: BoxDecoration(
        color: Colors.green[400],
        shape: BoxShape.circle,
      ),
    );

    return Material(
      color: Colors.green[100],
      child: Center(
        child: Stack(children: <Widget>[
          Center(child: repta),
          Center(child: pepta),
          for (var i = 0; i < totalSec; i++)
            ...[
              Center(
                  child: Tempas(
                indexPlace: i,
                bars: barba,
                baseValue: baseValue,
                innerOffset: innerOffset,
              )),
            ].reversed,
          for (var j = 0; j < minute; j++)
            ...[
              Center(
                  child: Tempas(
                indexPlace: j,
                bars: barbaw,
                baseValue: baseValue * 0.85,
                innerOffset: innerOffset,
              )),
            ].reversed,
          for (var k = 0; k < hour; k++)
            ...[
              Center(
                  child: Tempas(
                indexPlace: k,
                bars: sarbaw,
                baseValue: baseValue * 0.68,
                innerOffset: innerOffset,
                angle: angle2,
              )),
            ].reversed,
          Center(
              child: Text(
            (pol.hour.toInt() < 10
                    ? ('0' + pol.hour.toString())
                    : pol.hour.toString()) +
                ":" +
                (pol.minute.toInt() < 10
                    ? ('0' + pol.minute.toString())
                    : pol.minute.toString()),
            style: const TextStyle(fontSize: 50),
          )),
        ]),
      ),
    );
  }
}

class Tempas extends StatelessWidget {
  Tempas(
      {Key? key,
      required this.indexPlace,
      required this.bars,
      required this.baseValue,
      required this.innerOffset,
      this.angle = pi / 30})
      : super(key: key);

  final int indexPlace;
  final Widget? bars;
  final double baseValue;
  final double innerOffset;
  double angle = pi / 30;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
          cos(angle * indexPlace - pi / 2) * (baseValue - innerOffset / 2) / 2,
          sin(angle * indexPlace - pi / 2) * (baseValue - innerOffset / 2) / 2),
/*child: Text(
indexPlace < 10 ? '0' + indexPlace.toString() : indexPlace.toString(),
style: const TextStyle(
fontFamily: 'Audio',
fontSize: 8,
fontWeight: FontWeight.w100,
color: Colors.white),
),
*/
      child: Transform.rotate(
        angle: angle * indexPlace,
        child: bars,
      ),
    );
  }
}
