import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laborotory2/size_config.dart';

class Lab5P extends StatefulWidget {
  const Lab5P({super.key});

  @override
  State<Lab5P> createState() => _ToyCarPageState();
}

class _ToyCarPageState extends State<Lab5P> {
  double rotationAngle = 0;
  double distance = 0;
  double X = -2;
  double Y = 1;
  double count = 0;
  bool isTop = false;
  bool isReachedSecond = false;
  bool isFirstPassed = false;
  bool isSecondPassed = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Toy Car'),
      ),
      body: Container(
        width: 1000,
        child: Stack(
          children: [
            Text(
              'Tilt Angle: $rotationAngle, $distance, $X, $Y',
              style: TextStyle(fontSize: 18),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: getConfigHeight(0.202),
                horizontal: getConfigWidth(0.355),
              ),
              color: Colors.black,
              width: getConfigWidth(0.01),
              height: getConfigHeight(0.005),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: getConfigHeight(0.105),
                horizontal: getConfigWidth(0.35),
              ),
              child: Transform.rotate(
                angle: rotationAngle,
                origin: Offset(X, Y),
                child: Transform.translate(
                    offset: Offset(distance, Y),
                    // Translate vertically
                    child: Image.asset('assets/truckL.png',
                        width: 200, height: 100)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: getConfigHeight(0.05),
                horizontal: getConfigWidth(0.05),
              ),
              width: getConfigWidth(0.5),
              height: getConfigHeight(0.5),
              child: Image.asset(
                'assets/desk.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (!isFirstPassed) {
              if (!isTop) {
                rotationAngle += 0.01;
                distance = -rotationAngle * 100;
                X = distance;
                Y = 0;
                if (rotationAngle > 0.05) {
                  isTop = true;
                }
              } else {
                count += 1;
                rotationAngle -= 0.01;
                distance = -rotationAngle * 100 - 0.05 * (count * 100);
                Y = 0;
                if (rotationAngle < 0) {
                  isFirstPassed = true;
                  count = 0;
                }
              }
            } else if(!isReachedSecond){
               if (count < 7) {
                 distance = distance - 8;
                 count += 1;
               }else{
                 isReachedSecond = true;
                 isTop = false;
               }
            }

            if (!isSecondPassed && isReachedSecond){
              if (!isTop) {
                rotationAngle -= 0.02;
                distance = distance + rotationAngle * 100;
                X = distance;
                Y = 0;
                if (rotationAngle <-0.05) {
                  isTop = true;
                }
              } else {
                count += 1;
                rotationAngle += 0.02;
                distance = distance + rotationAngle * 100;
                Y = 0;
                if (rotationAngle > 0) {
                  isSecondPassed = true;
                  count = 0;
                }
              }
            } else{
              if (count < 7) {
                distance = distance - 8;
                count += 1;
              }
            }

          });
        },
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}
