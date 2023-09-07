import 'package:flutter/material.dart';

class customTextFormField extends StatelessWidget {
   customTextFormField({this.onChanged,required this.hinttext,this.obscureText=false}) ;
String? hinttext;
   Function(String)? onChanged;
   bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
        obscureText: obscureText!,

      validator: (data){
        if(data!.isEmpty){
          return'field is required';

        }
        return null;

      },
      onChanged:onChanged ,
      decoration: InputDecoration(
        hintText:hinttext,
        hintStyle: const TextStyle(
          color: Colors.white
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white

            )

        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white


          ),

        ),



      ),


    );


  }
}
