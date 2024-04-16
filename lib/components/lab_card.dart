import 'package:flutter/material.dart';
import 'package:laborotory2/size_config.dart';

class LabsCard extends StatelessWidget {
  const LabsCard({super.key, required this.imageUrl, required this.name});

  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getConfigHeight(0.365),
      width: getConfigWidth(0.2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            height: 200,
            imageUrl,
            fit: BoxFit.fill,
            scale: 1,
          ),
          SizedBox(height: 4,),

          Text(name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),)
        ],
      ),
    );
  }
}
