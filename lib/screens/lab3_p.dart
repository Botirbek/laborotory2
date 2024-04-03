import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laborotory2/components/formula_element.dart';
import 'package:laborotory2/size_config.dart';

class Lab3P extends StatefulWidget {
  const Lab3P({super.key});

  @override
  State<Lab3P> createState() => _Lab3PState();
}

class _Lab3PState extends State<Lab3P>   with SingleTickerProviderStateMixin{
  bool touched = false;
  String result = "0";
  TextEditingController m1 = TextEditingController();
  TextEditingController m2 = TextEditingController();
  TextEditingController m3 = TextEditingController();
  TextEditingController m4 = TextEditingController();

  late AnimationController controller;
  late Tween<Alignment> alignmentTween; // <<< Tween for first animation
  late Tween<double> rotateTween; // <<< Tween for second animation
  late Animation<Alignment> alignmentAnimation; // <<< first animation
  late Animation<double> rotateAnimation; // <

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    alignmentTween = Tween(
        begin: Alignment(0.5, -1),
        end:  Alignment(-0.5, -1) ); // <<< define start and end value of alignment animation
    rotateTween = Tween(
        begin: 0,
        end: 1/8 * pi); // <<< define start and end value of rotation animation
    alignmentAnimation =
        controller.drive(alignmentTween); // <<< create align animation
    rotateAnimation =
        controller.drive(rotateTween); // <<< create rotation animation
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
              SizedBox(width: getConfigWidth(0.4),),
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
        AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Align(
              alignment: alignmentAnimation.value, // <<< bind align animation
              child: Transform.rotate(
                angle: rotateAnimation.value, // <<< bind rotation animation
                child: Image.asset('assets/truckL.png'),
              ),
            );
          },
        ),
        AnimatedPositioned(
          top: getConfigHeight(0.112),
          left: touched ? getConfigWidth(0.35) : getConfigWidth(0.23),
          duration: const Duration(seconds: 8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                touched = !touched;
              });
            },
            child: Image.asset(
              'assets/truckL.png',
              width: getConfigWidth(0.2),
              height: getConfigHeight(0.1),
              fit: BoxFit.fill,
            ),
          ),
        ),
        AnimatedPositioned(
          top: touched ? getConfigHeight(0.24) : getConfigHeight(0.44),
          left: getConfigWidth(0.025),
          duration: const Duration(seconds: 9),
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            onTap: () {
              setState(() {
                touched = !touched;
              });
            },
            child: Image.asset(
              'assets/massa.png',
              width: getConfigWidth(0.08),
              height: getConfigHeight(0.06),
              fit: BoxFit.fill,
            ),
          ),
        ),

      ]),
    );
  }

  _parameters() {

    return Container(
      margin: EdgeInsets.all(16),
      width: getConfigWidth(0.35),
      height: getConfigHeight(0.85),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          formula(text: 'Аvtomobilning oldingi gʼildiraklaridagi massasi', symbol: 'assets/mk.png', textEditingController: m1, ),
          formula(text: 'Gʼildirak radiusi', symbol: 'assets/rk.png', textEditingController: m2,),
          formula(text: 'Yoʼl sathidan koʼtarilishi', symbol: 'assets/ht.png', textEditingController: m3,),
          formula(text: 'Oʼtuvchanlik burchaklari', symbol: 'assets/rk.png', textEditingController: m4,),

          Row(
            children: [
              Image.asset(
                'assets/lab3_formula.png',
                scale: 2,
                fit: BoxFit.fill,
              ),
              Text(' = '),

              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 4),
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child:Text('$result' ,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: getConfigHeight(0.1),),
          OutlinedButton(
            onPressed: (){
                setState(() {
                    var mk =  double.parse(m1.text.isNotEmpty ? m1.text : '0');
                    var rk =  double.parse(m2.text.isNotEmpty ? m2.text : '0');
                    var ht =  double.parse(m3.text.isNotEmpty ? m3.text : '0');
                    var n4 =  double.parse(m4.text.isNotEmpty ? m4.text : '0');

                    result = (mk * 9.81 * sqrt((2*rk*ht-pow(ht, 2))/(rk - ht))).toStringAsFixed(3);

                });
                controller.forward();
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.transparent),
              ),
            ),
            child: const Text(
              'Hisoblash',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

        ],
      ),
    );
  }

}
