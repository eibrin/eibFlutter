import 'package:flutter/material.dart';

import '../../models/body.dart';

class BMIAni extends StatefulWidget {
  const BMIAni({super.key});

  @override
  State<BMIAni> createState() => _BMIAniState();
}

class _BMIAniState extends State<BMIAni> {
  List<Body> body = [];
  Color weightColor = Colors.blue;
  int current = 0;
  double _opacity = 1;

  @override
  void initState() {
    // TODO: implement initState
    body.add(Body('고재형', 190, 120));
    body.add(Body('신예지', 160, 45));
    body.add(Body('나예리', 185, 55));
    body.add(Body('지오지', 153, 75));
    body.add(Body('민호라', 170, 94));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 1),
            child: SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text('이름: ${body[current].name}'),
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 2),
                    curve: Curves.bounceIn,
                    color: Colors.amber,
                    child: Text(
                      '키 ${body[current].height}',
                      textAlign: TextAlign.center,
                    ),
                    width: 50,
                    height: body[current].height,
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 2),
                    curve: Curves.easeInCubic,
                    color: weightColor,
                    child: Text(
                      '몸무게 ${body[current].weight}',
                      textAlign: TextAlign.center,
                    ),
                    width: 50,
                    height: body[current].weight,
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 2),
                    curve: Curves.linear,
                    color: Colors.pinkAccent,
                    child: Text(
                      '키 ${body[current].bmi.toString().substring(0, 2)}',
                      textAlign: TextAlign.center,
                    ),
                    width: 50,
                    height: body[current].bmi,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              height: 200,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (current < body.length - 1) {
                    current++;
                    _changeWeightColor(body[current].weight!);
                  }
                });
              },
              child: Text('다음')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (current > 0) {
                    current--;
                    _changeWeightColor(body[current].weight!);
                  }
                });
              },
              child: Text('이전')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _opacity == 1 ? _opacity = 0 : _opacity = 1;
                });
              },
              child: Text('사라지기')),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  void _changeWeightColor(double weight) {
    if (weight < 50) {
      weightColor = Colors.blueAccent;
    } else if (weight < 70) {
      weightColor = Colors.indigo;
    } else if (weight < 90) {
      weightColor = Colors.orange;
    } else {
      weightColor = Colors.red;
    }
  }
}
