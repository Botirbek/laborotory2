import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laborotory2/size_config.dart';

formula(
    {required String text,
    required String symbol,
    required TextEditingController textEditingController}) {
  return Container(
    width: getConfigWidth(0.35),
    height: 80,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: getConfigWidth(0.2),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        SizedBox(
            width: 40,
            child: Image.asset(symbol)),
        Text(' = '),
        Container(
          padding: EdgeInsets.only(left: 10),
          width: 80,
          height: 36,
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white),
          child: Center(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              textAlign: TextAlign.start,
              // maxLength: 5,
              maxLines: 1,
              controller: textEditingController,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, height: 1.25),
              decoration: InputDecoration.collapsed(
                hintText: '',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
