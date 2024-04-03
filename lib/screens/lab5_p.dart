import 'package:flutter/material.dart';

class Lab5P extends StatefulWidget {
  const Lab5P({super.key});

  @override
  State<Lab5P> createState() => _ToyCarPageState();
}

class _ToyCarPageState extends State<Lab5P> {
  double rotationAngle = 0;
  double distance = 0;
  double X = 0;
  double Y = 0;
  double count = 0;
  bool isPassed = false;
  bool isStopped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toy Car'),
      ),
      body: Container(
        width: 1000,
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'Tilt Angle: $rotationAngle, $distance, $X, $Y',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Transform.rotate(
              angle: rotationAngle,
              origin: Offset(X, Y),
              child: Transform.translate(
                  offset: Offset(distance, Y),
                  // Translate vertically
                  child: Image.asset('assets/truckL.png',
                      width: 200, height: 100)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
              if (!isPassed && !isStopped) {
                rotationAngle += 0.01;
                distance = -rotationAngle * 100;
                X = distance;
                Y = 0;
                if (rotationAngle > 0.1) {
                  isPassed = true;
                }
              } else if (!isStopped) {
                count += 1;
                rotationAngle -= 0.01;
                distance = -rotationAngle * 100 - 0.02 * (count * 100);
                Y = 0;
                if (rotationAngle < 0) {
                  isStopped = true;
                }
              }
          });
        },
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}
