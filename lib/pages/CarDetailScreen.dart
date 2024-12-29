// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CarDetailScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarDetailScreen({super.key, required this.car});

  @override
  _CarDetailScreenState createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
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

    if (tenureInMonths <= 360) {
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
    } else {
      print(
          "The loan tenure is longer than the allowed value. Max value is 360 months or 30 years");
      _showSnackbar(
          "The loan tenure is longer than the allowed value. Max value is 360 months or 30 years");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // down paly ment function ###############3

  void updateLoanAmount(double percentage) {
    double carPrice = double.parse(widget
        .car['price']); // Ensure the car price exists in the widget.car map.
    double downPayment = carPrice * (percentage / 100);
    double loanAmount = carPrice - downPayment;

    setState(() {
      loanAmountController.text = loanAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Car Image
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        widget.car['assetImagePath'],
                        height: height * 0.3,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Car Details
                  SizedBox(
                    height: height * 0.4,
                    width: width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.car['title'],
                          style: TextStyle(
                            fontSize: height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "features",
                          style: TextStyle(
                              fontSize: height * 0.025,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        ...List<Map<String, dynamic>>.from(
                                widget.car['details'])
                            .map(
                          (detail) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Icon(
                                  detail['icon'],
                                  size: 20.0,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    detail['text'],
                                    style: TextStyle(
                                      fontSize: height * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // pie chart #################################

                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.35,
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
                                radius: 80,
                                titleStyle: TextStyle(
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              PieChartSectionData(
                                value: totalInterest > 0
                                    ? totalInterest
                                    : 1, // Avoid zero value
                                color: const Color.fromARGB(255, 26, 60, 211),
                                title: 'Interest',
                                radius: 80,
                                titleStyle: TextStyle(
                                    fontSize: height * 0.02,
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

            // cacuator body###################################

            // text fild #############################
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "EMI Calculator",
                        style: TextStyle(
                            fontSize: width * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.3,
                        width: width * 0.3,
                        child: Card(
                          elevation: 1,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: height * 0.06,
                                    width: width * 0.26,
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
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),

                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                ),

                                //Lone Rate############

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: height * 0.06,
                                    width: width * 0.26,
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
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),

                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                ),

                                // months ########################

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: height * 0.06,
                                    width: width * 0.26,
                                    child: TextField(
                                      controller: tenureController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Loan (Months)',

                                        fillColor: Colors.white,
                                        filled: true,

                                        // labelText: "Loan Amount (Rs)",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),

                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.09,
                        width: width * 0.2,
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context)
                                .unfocus(); // Dismiss the keyboard
                            calculateEMI();
                          },
                          child: Card(
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                "Calculate",
                                style: TextStyle(
                                    fontSize: width * 0.02,
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
                  width: width * 0.01,
                ),

                // out puts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                Container(
                  height: height * 0.3,
                  width: width * 0.28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Breakdown',
                          style: TextStyle(
                              fontSize: height * 0.03,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: height * 0.03,
                      ),

                      Row(
                        children: [
                          SizedBox(
                            height: height * 0.1,
                            width: width * 0.14,
                            child: Card(
                              elevation: 1,
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text("Monthly Payment",
                                        style: TextStyle(
                                            fontSize: height * 0.02,
                                            fontWeight: FontWeight.bold)),
                                    Text("Rs ${emi.toStringAsFixed(2)}")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.1,
                            width: width * 0.14,
                            child: Card(
                              elevation: 1,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Text("Total Interest",
                                      style: TextStyle(
                                          fontSize: height * 0.024,
                                          fontWeight: FontWeight.bold)),
                                  Text("Rs ${totalInterest.toStringAsFixed(2)}")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // total intrast #####################

                      // Total Payment ##############################160786
                      SizedBox(
                        height: height * 0.1,
                        width: width * 0.2,
                        child: Card(
                          elevation: 1,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Text("Total Payment",
                                  style: TextStyle(
                                      fontSize: height * 0.024,
                                      fontWeight: FontWeight.bold)),
                              Text("Rs ${totalPayment.toStringAsFixed(2)}")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  width: width * 0.01,
                ),

                // interst rates##########################

                Container(
                  height: height * 0.4,
                  width: width * 0.3,
                  child: Column(
                    children: [
                      Text('Down Payment',
                          style: TextStyle(
                              fontSize: height * 0.03,
                              fontWeight: FontWeight.bold)),

                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ooptions#############3
                          GestureDetector(
                            onTap: () => updateLoanAmount(0), // 0% Down Payment
                            child: SizedBox(
                              height: height * 0.1,
                              width: width * 0.1,
                              child: Card(
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    "0%",
                                    style: TextStyle(
                                        fontSize: width * 0.03,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () =>
                                updateLoanAmount(20), // 20% Down Payment
                            child: SizedBox(
                              height: height * 0.1,
                              width: width * 0.1,
                              child: Card(
                                color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  "20%",
                                  style: TextStyle(
                                      fontSize: width * 0.03,
                                      color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // second options #############################################
                      SizedBox(
                        height: height * 0.03,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ooptions#############3
                          GestureDetector(
                            onTap: () =>
                                updateLoanAmount(40), // 40% Down Payment
                            child: SizedBox(
                              height: height * 0.1,
                              width: width * 0.1,
                              child: Card(
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    "40%",
                                    style: TextStyle(
                                        fontSize: width * 0.03,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () =>
                                updateLoanAmount(60), // 60% Down Payment
                            child: SizedBox(
                              height: height * 0.1,
                              width: width * 0.1,
                              child: Card(
                                color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  "60%",
                                  style: TextStyle(
                                      fontSize: width * 0.03,
                                      color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
