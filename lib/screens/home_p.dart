import 'package:flutter/material.dart';
import 'package:laborotory2/components/lab_card.dart';
import 'package:laborotory2/screens/lab3_p.dart';
import 'package:laborotory2/screens/lab4_p.dart';
import 'package:laborotory2/screens/lab5_p.dart';
import 'package:laborotory2/size_config.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  bool onWindowResize() {
    return false;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
      child: Scaffold(
        body: Container(
          width: getConfigWidth(1),
          height: getConfigFullHeight(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Transport vositalarining tuzilishi va nazariyasi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: (getConfigHeight(0.08)),
                ),
              ),
              SizedBox(
                height: getConfigHeight(0.05),
              ),
              // Text(
              //   'Labaratoriya ishlari',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: getConfigHeight(0.08),
              //   ),
              // ),
              SizedBox(height: getConfigWidth(0.08)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: const LabsCard(
                        imageUrl: 'assets/lab_icon1.jpg', name: 'Laboratoriya 3'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Lab3P(),
                      ));
                    },
                  ),

                  InkWell(
                    child: const LabsCard(
                        imageUrl: 'assets/lab_icon1.jpg', name: 'Laboratoriya 4'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Lab4P(),
                      ));
                    },
                  ),

                  InkWell(
                    child: const LabsCard(
                        imageUrl: 'assets/lab_icon1.jpg', name: 'Laboratoriya 5'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Lab5P(),
                      ));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
