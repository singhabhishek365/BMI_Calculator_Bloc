import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/bloc/bmi_event.dart';
import 'package:bmi_calculator/bloc/bmi_state.dart';
import 'package:bmi_calculator/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // initilize text editing controller in init state
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _height = TextEditingController();

  @override
  void initState() {
    _weight.text = '';
    _height.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _height;
    _weight;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(
              "assets/bg.svg",
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "BMI Calculator",
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        const Text("Enter Height (Mtr)",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: _height,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Enter your height in meters",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          "Enter Weight (Kg)",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: _weight,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Enter your weight in Kg",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                        BlocBuilder<BmiBloc, BmiState>(
                            builder: (context, state) {
                          return Column(children: [
                            Visibility(
                              visible: (state as BmiResult).visible,
                              child: Column(children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 50,
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.blue, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Result",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          state.bmi.toStringAsFixed(2),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: state.color,
                                    border: Border.all(
                                        color: Colors.blue, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    state.bmiCategory,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            InkWell(
                              onTap: () {
                                if (_weight.text.isEmpty ||
                                    _height.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Kindly Enter Weight And Height both')));
                                } else {
                                  BlocProvider.of<BmiBloc>(context).add(
                                      ShowResult(double.parse(_height.text),
                                          double.parse(_weight.text)));
                                }
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: kPrimaryGradient,
                                  border: Border.all(
                                      width: 0.3, color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "Result",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                              ),
                            ),
                          ]);
                        })
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
