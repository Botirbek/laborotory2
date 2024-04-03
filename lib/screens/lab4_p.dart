import 'dart:math';

import 'package:flutter/material.dart';

class Lab4P extends StatefulWidget {
  const Lab4P({super.key});

  @override
  State<Lab4P> createState() => _CarAnimationState();
}

class _Lab4PState extends State<Lab4P> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Laboratoriya 4',
              style: TextStyle(
                fontSize: 50,
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}

class _CarAnimationState extends State<Lab4P>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1, end: -1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Animation'),
      ),
      body: Center(
          child: Column(children: [
          Transform.rotate(
            angle: _animation.value * pi/8, // Rotate 360 degrees
            origin: Offset(0, 0), // Adjust origin to the wheel location
            child: Transform.translate(
              offset: Offset(_animation.value * 15, 0),
              // Translate vertically
              child: Image.asset('assets/truckL.png', width: 100, height: 50),
            ),
          ),
      ])),
    );
  }
}
