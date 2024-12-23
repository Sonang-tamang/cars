// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Emi extends StatefulWidget {
  const Emi({super.key});

  @override
  State<Emi> createState() => _EmiState();
}

class _EmiState extends State<Emi> {
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController tenureController = TextEditingController();

  double emi = 0.0;
  double totalInterest = 0.0;
  double totalPayment = 0.0;

  // calculatio$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  void calculateEMI() {
    double principal = double.tryParse(loanAmountController.text) ?? 0.0;
    double annualRate = double.tryParse(interestRateController.text) ?? 0.0;
    int tenureInMonths = int.tryParse(tenureController.text) ?? 0;

    double monthlyRate = annualRate / 12 / 100;

    if (monthlyRate == 0 || tenureInMonths == 0) {
      setState(() {
        emi = 0.0;
        totalInterest = 0.0;
        totalPayment = 0.0;
      });
      return;
    }

    emi = principal *
        monthlyRate *
        pow((1 + monthlyRate), tenureInMonths) /
        (pow((1 + monthlyRate), tenureInMonths) - 1);

    totalPayment = emi * tenureInMonths;
    totalInterest = totalPayment - principal;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('EMI Calculator'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "CAR EMI Calculator",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.5,
                          width: width * 0.4,
                          child: Card(
                            elevation: 20,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: loanAmountController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Loan Amount (Rs)',
                                        fillColor: Colors.white,
                                        filled: true,

                                        // labelText: "Loan Amount (Rs)",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),

                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),

                                  //Lone Rate############

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: interestRateController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Interest Rate (%)',

                                        fillColor: Colors.white,
                                        filled: true,

                                        // labelText: "Loan Amount (Rs)",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),

                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),

                                  // months ########################

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: tenureController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Tenure (Months)',

                                        fillColor: Colors.white,
                                        filled: true,

                                        // labelText: "Loan Amount (Rs)",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),

                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.07,
                        ),
                        SizedBox(
                          height: height * 0.09,
                          width: width * 0.2,
                          child: InkWell(
                            onTap: () {
                              calculateEMI();
                            },
                            child: Card(
                              color: Colors.blue,
                              child: Center(
                                child: Text(
                                  "Calculate",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // pie chart#####################160786

                  SizedBox(
                    width: width * 0.03,
                  ),

                  // out puts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                  Container(
                    height: height * 0.4,
                    width: width * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Breakdown',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          height: height * 0.1,
                          width: width,
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Text("Loan EMI"),
                                Text("Rs ${emi.toStringAsFixed(2)}")
                              ],
                            ),
                          ),
                        ),

                        // total intrast #####################

                        SizedBox(
                          height: height * 0.1,
                          width: width,
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Text("Total Interest Payable"),
                                Text("Rs ${totalInterest.toStringAsFixed(2)}")
                              ],
                            ),
                          ),
                        ),

                        // Total Payment ##############################160786
                        SizedBox(
                          height: height * 0.1,
                          width: width,
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Text("Total Payment"),
                                Text("Rs ${totalPayment.toStringAsFixed(2)}")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    width: width * 0.04,
                  ),

                  // pie chart #################################

                  SizedBox(
                    height: height * 0.5,
                    width: width * 0.3,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            // value: totalPayment - totalInterest,
                            value: totalPayment - totalInterest > 0
                                ? totalPayment - totalInterest
                                : 1, // Avoid zero value
                            color: Colors.blue,
                            title: 'Principal',
                            radius: 60,
                            titleStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          PieChartSectionData(
                            value: totalInterest > 0
                                ? totalInterest
                                : 1, // Avoid zero value
                            color: const Color.fromARGB(255, 26, 60, 211),
                            title: 'Interest',
                            radius: 60,
                            titleStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
