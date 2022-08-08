import 'package:flutter/material.dart';

// if we have more than one state we will use this Class currently this is just for refrence 
abstract class BmiState {}

class BmiResult extends BmiState {
  double bmi = 1;
  String bmiCategory = '';
  bool visible = false;
  Color color = Colors.white;

  BmiResult();

}



