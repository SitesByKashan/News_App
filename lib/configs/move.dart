
import 'package:flutter/material.dart';

gonext(page,context){
  Navigator.push(context, 
  MaterialPageRoute(
    builder: (context) => page 
  ));
}

goreplace(page,context){
  Navigator.pushReplacement(context, 
  MaterialPageRoute(
    builder: (context) => page 
  ));
}

back(context){
  Navigator.pop(context);
}