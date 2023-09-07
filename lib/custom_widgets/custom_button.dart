import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
   custombutton({ this.onTap,required this.text}) ;
String? text;
VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),

        ),
        width: double.infinity,
        height: 40,

        child: Center(child: Text(text!)),

      ),
    );

  }
}
