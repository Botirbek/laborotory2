import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:laborotory2/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool touched = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Container(
        width: getConfigWidth(1),
        height: getConfigFullHeight(),
        child: Stack(children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: getConfigHeight(0.05),
              horizontal: getConfigWidth(0.1),
            ),
            width: getConfigWidth(0.7),
            height: getConfigHeight(0.7),
            child: Image.asset(
              'assets/desk.png',
              fit: BoxFit.fill,
            ),
          ),
          AnimatedPositioned(
            top: getConfigHeight(0.165),
            left: touched ? getConfigWidth(0.5) : getConfigWidth(0.3),
            duration: const Duration(seconds: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  touched = !touched;
                });
              },
              child: Image.asset(
                'assets/truckL.png',
                width: getConfigWidth(0.25),
                height: getConfigHeight(0.11),
                fit: BoxFit.fill,
              ),
            ),
          ),
          AnimatedPositioned(
            top: touched ? getConfigHeight(0.32) : getConfigHeight(0.55),
            left: getConfigWidth(0.072),
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
                width: getConfigWidth(0.1),
                height: getConfigHeight(0.08),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
