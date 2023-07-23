import 'package:flutter/material.dart';

class buttonCard extends StatelessWidget {
  final btncolor;
  final textColor;
  final String text;
  final ontap;
  const buttonCard(
      {super.key,
      required this.btncolor,
      required this.text,
      required this.textColor,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GestureDetector(
          onTap: ontap,
          child: Container(
            color: btncolor,
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
