import 'package:bmi_calculator/bloc/bmi_event.dart';
import 'package:bmi_calculator/bloc/bmi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  // define initial state value in class
  BmiBloc() : super(BmiResult()) {
    on<ShowResult>((event, emit) {
      BmiResult result = BmiResult();
      result.bmi = calculation(event.weight, event.height);
      result.bmiCategory = strResult(result.bmi);
      result.color = containercolor(result.bmi);
      result.visible = true;

      emit(result);
    });
  }

  // Returns BMI Digit
  double calculation(double weight, double height) {
    return (weight) / ((height) * (height));
  }

// Returns BMI String Healthy or Not
  String strResult(double result) {
    // Basic spelling should be correct
    if (result < 18.5) {
      return 'Underweight';
    } else if (result >= 18.5 && result < 25) {
      return ' Congratulations You are in Normal Range';
    } else if (result >= 25 && result <= 29.9) {
      return 'Champ Need To Work Out (Overweight)';
    } else if (result >= 30) {
      return 'Kindly join gym (Obese)';
    }
    return '';
  }

// Returns BMI Container Color according to result value
  Color containercolor(double? result) {
    if (result! < 18.5) {
      return Colors.pink;
    } else if (result >= 18.5 && result < 25) {
      return Colors.green;
    } else if (result >= 25 && result <= 29.9) {
      return Colors.redAccent;
    } else if (result >= 30) {
      return Colors.red;
    }
    return Colors.white;
  }
}
