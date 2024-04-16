import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:laborotory2/components/formula_element.dart';
import 'package:laborotory2/size_config.dart';

class Lab3P extends StatefulWidget {
  const Lab3P({super.key});

  @override
  State<Lab3P> createState() => _Lab3PState();
}

class _Lab3PState extends State<Lab3P> with SingleTickerProviderStateMixin {
  String result = "0";

  double rotationAngle = 0;
  double distance = 0;
  double X = -2;
  double Y = 1;
  double Mx = 1;
  double My = 1;
  double Rx = 1;
  double Ry = 1;
  double count = 0;
  double count1 = 0;
  bool isTop = false;
  bool isStopped = false;
  bool isReachedSecond = false;
  bool isFirstPassed = false;
  bool isSecondPassed = false;
  bool isFrintWheel = true;
  bool isTruck = false;

  final List<bool> isSelected = <bool>[true, false];
  final List<bool> isSelectedVehicleType = <bool>[true, false];

  TextEditingController m1 = TextEditingController();
  TextEditingController m2 = TextEditingController();
  TextEditingController m3 = TextEditingController();
  TextEditingController m4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Container(
        width: getConfigWidth(1),
        height: getConfigFullHeight(),
        child: Column(children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              SizedBox(
                width: getConfigWidth(0.4),
              ),
              const Text(
                'Laboratoriya 3',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _printLab(),
              _parameters(),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _printLab() {
    return Container(
      width: getConfigWidth(0.6),
      height: getConfigHeight(0.7),
      margin: EdgeInsets.only(top: getConfigHeight(0.1)),
      child: Stack(children: [
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
        Positioned(
          top: getConfigHeight(0.202),
          left: getConfigWidth(0.355),
          child: Container(
            color: Colors.black,
            width: getConfigWidth(0.01),
            height: getConfigHeight(0.005),
          ),
        ),
        Positioned(
          top: getConfigHeight(0.167),
          left: getConfigWidth(0.12),
          child: Transform.scale(
            scaleX: Rx,
            child: Image.asset(
              'assets/ropeH.png',
              width: getConfigWidth(0.25),
              height: 2,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Visibility(
          visible: isTruck,
          child: Positioned(
            top: getConfigHeight(0.1),
            left: isFrintWheel ? getConfigWidth(0.347) : getConfigWidth(0.265),
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
        ),
        Visibility(
          visible: !isTruck,
          child: Positioned(
            top: getConfigHeight(0.11),
            left: isFrintWheel ? getConfigWidth(0.327) : getConfigWidth(0.250),
            child: Transform.rotate(
              angle: rotationAngle,
              origin: Offset(X, Y),
              child: Transform.translate(
                  offset: Offset(distance, Y),
                  // Translate vertically
                  child:
                      Image.asset('assets/car2.png', width: 200, height: 100)),
            ),
          ),
        ),
        Positioned(
          top: getConfigHeight(0.3),
          left: getConfigWidth(0.0245),
          child: Transform.translate(
            offset: Offset(Mx, My),
            child: Image.asset(
              'assets/massa.png',
              width: getConfigWidth(0.08),
              height: getConfigHeight(0.05),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: getConfigHeight(0.24),
          left: getConfigWidth(0.065),
          child: Transform.scale(
            scaleY: Ry,
            child: Image.asset(
              'assets/ropeV.png',
              width: 2,
              height: getConfigHeight(0.07),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ]),
    );
  }

  _parameters() {
    return Container(
      margin: const EdgeInsets.all(16),
      width: getConfigWidth(0.35),
      height: getConfigHeight(0.85),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: getConfigWidth(0.16),
                child: const Text(
                  'Avtomobil turi ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ToggleButtons(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  selectedColor: Colors.white,
                  fillColor: Colors.green,
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 30.0,
                    minWidth: 80.0,
                  ),
                  isSelected: isSelectedVehicleType,
                  onPressed: (int index) {
                    setState(() {
                      isTruck = index == 0;
                      reset();
                      for (int i = 0; i < isSelectedVehicleType.length; i++) {
                        isSelectedVehicleType[i] = i == index;
                      }
                    });
                  },
                  children: const [
                    Text(' Yuk moshina '),
                    Text(' Yengil avtomobil '),
                  ]),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(
                width: getConfigWidth(0.18),
                child: const Text(
                  'To' 'siqning joylashuvi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ToggleButtons(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  selectedColor: Colors.white,
                  fillColor: Colors.green,
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 30.0,
                    minWidth: 80.0,
                  ),
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      isFrintWheel = index == 0;
                      reset();
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    });
                  },
                  children: const [
                    Text(' Yetaklovchi '),
                    Text(' Yetaklanovchi '),
                  ]),
            ],
          ),
          formula(
            text: 'Аvtomobilning oldingi gʼildiraklaridagi massasi',
            symbol: 'assets/mk.png',
            textEditingController: m1,
          ),
          formula(
            text: 'Gʼildirak radiusi',
            symbol: 'assets/rk.png',
            textEditingController: m2,
          ),
          formula(
            text: 'Yoʼl sathidan koʼtarilishi',
            symbol: 'assets/ht.png',
            textEditingController: m3,
          ),
          formula(
            text: 'Oʼtuvchanlik burchaklari',
            symbol: 'assets/rk.png',
            textEditingController: m4,
          ),
          Row(
            children: [
              Image.asset(
                'assets/lab3_formula.png',
                scale: 2,
                fit: BoxFit.fill,
              ),
              const Text(' = '),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 4),
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(
                  '$result',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getConfigHeight(0.1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () async {
                  // print('pressed');
                  setState(() {
                    var mk = double.parse(m1.text.isNotEmpty ? m1.text : '0');
                    var rk = double.parse(m2.text.isNotEmpty ? m2.text : '0');
                    var ht = double.parse(m3.text.isNotEmpty ? m3.text : '0');
                    var n4 = double.parse(m4.text.isNotEmpty ? m4.text : '0');

                    result = (mk *
                            9.81 *
                            sqrt((2 * rk * ht - pow(ht, 2)) / (rk - ht)))
                        .toStringAsFixed(3);
                  });

                  if (isTruck) {
                    isFrintWheel ? playTruck1() : playTruck2();
                  } else {
                    isFrintWheel ? playCar1() : playCar2();
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                ),
                child: const Text(
                  'Boshlash',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  reset();
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                ),
                child: const Text(
                  'Yakunlash',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void reset() async {
    setState(() {
      rotationAngle = 0;
      distance = 0;
      X = -2;
      Y = 1;
      Mx = 1;
      My = 1;
      Rx = 1;
      Ry = 1;
      count = 0;
      count1 = 0;
      isTop = false;
      isStopped = false;
      isReachedSecond = false;
      isFirstPassed = false;
      isSecondPassed = false;
      result = "0";
    });
  }

  void playCar1() async {
    while (count1 < 28) {
      // print('c = $count1');
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
          count1 += 1;
          My += 2;
          Rx -= 0.01;
          Ry += 0.07;

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
              distance = distance - rotationAngle * 100 ;
              Y = 0;
              if (rotationAngle < 0) {
                isFirstPassed = true;
                count = 0;
              }
            }
          } else if (!isReachedSecond) {
            if (count < 7) {
              distance = distance - 8;
              count += 1;
            } else {
              isReachedSecond = true;
              isTop = false;
            }
          }

          if (!isSecondPassed && isReachedSecond) {
            if (!isTop) {
              rotationAngle -= 0.02;
              distance = distance + rotationAngle * 100;
              X = distance;
              Y = 0;
              if (rotationAngle < -0.1) {
                isTop = true;
              }
            } else {
              count += 1;
              rotationAngle += 0.03;
              distance = distance + rotationAngle * 50;
              Y = 0;
              if (rotationAngle > -0.02) {
                isSecondPassed = true;
                count = 0;
              }
            }
          } else {
            if (count < 7) {
              distance = distance - 8;
              count += 1;
            }
            isStopped = true;
          }
        },
      );
    }
  }

  void playCar2() async {
    while (count1 < 12) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        count1 += 1;
        My += 2;
        Rx -= 0.01;
        Ry += 0.07;

        if (!isSecondPassed) {
          if (!isTop) {
            rotationAngle -= 0.02;
            distance = distance + rotationAngle * 50;
            X = distance;
            Y = 0;
            if (rotationAngle < -0.1) {
              isTop = true;
            }
          } else {
            count += 1;
            rotationAngle += 0.03;
            distance = distance + rotationAngle * 50;
            Y = 0;
            if (rotationAngle > -0.02) {
              isSecondPassed = true;
              count = 0;
            }
          }
        } else {
          if (count < 7) {
            distance = distance - 8;
            count += 1;
          }
          isStopped = true;
        }
      });
    }
  }

  void playTruck1() async {
    while (count1 < 28) {
      // print('c = $count1');
      await Future.delayed(const Duration(milliseconds: 100));
      setState(
        () {
          count1 += 1;
          My += 2;
          Rx -= 0.01;
          Ry += 0.07;

          if (!isFirstPassed) {
            if (!isTop) {
              rotationAngle += 0.02;
              distance = -rotationAngle * 50;
              X = distance;
              Y = 0;
              if (rotationAngle > 0.05) {
                isTop = true;
              }
            } else {
              count += 1;
              rotationAngle -= 0.01;
              distance = distance - rotationAngle * 50 ;
              Y = 0;
              if (rotationAngle < 0) {
                isFirstPassed = true;
                count = 0;
              }
            }
          } else if (!isReachedSecond) {
            if (count < 7) {
              distance = distance - 8;
              count += 1;
            } else {
              isReachedSecond = true;
              isTop = false;
            }
          }

          if (!isSecondPassed && isReachedSecond) {
            if (!isTop) {
              rotationAngle -= 0.03;
              distance = distance + rotationAngle * 150;
              X = distance;
              Y = 0;
              if (rotationAngle < -0.1) {
                isTop = true;
              }
            } else {
              count += 1;
              rotationAngle += 0.03;
              distance = distance + rotationAngle * 100;
              Y = 0;
              if (rotationAngle > -0.03) {
                isSecondPassed = true;
                count = 0;
              }
            }
          } else {
            if (count < 7) {
              distance = distance - 8;
              count += 1;
            }
            isStopped = true;
          }
        },
      );
    }
  }

  void playTruck2() async {
    while (count1 < 10) {
      // print('c = $count1');
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        count1 += 1;
        My += 2;
        Rx -= 0.01;
        Ry += 0.07;

        if (!isSecondPassed) {
          if (!isTop) {
            rotationAngle -= 0.03;
            distance = distance + rotationAngle * 100;
            X = distance;
            Y = 0;
            if (rotationAngle < -0.1) {
              isTop = true;
            }
          } else {
            count += 1;
            rotationAngle += 0.03;
            distance = distance + rotationAngle * 150;
            Y = 0;
            if (rotationAngle > -0.03) {
              isSecondPassed = true;
              count = 0;
            }
          }
        } else {
          if (count < 7) {
            distance = distance - 8;
            count += 1;
          }
          isStopped = true;
        }
      });
    }
  }
}
