import 'dart:convert';

import 'package:craft_dynamic/antochanges/extensions.dart';
import 'package:craft_dynamic/antochanges/loan_list_item.dart';
import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:flutter/material.dart';
CommonSharedPref _sharedPrefs = CommonSharedPref();


class LoanListScreen extends StatefulWidget {
  const LoanListScreen({super.key});

  @override
  State<LoanListScreen> createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {
  final _apiServices = APIService();
  @override
  void initState() {
    _apiServices.getLoanInfo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Loan Information'),),
        body: FutureBuilder(
          future: _apiServices.getLoanInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget child = Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.active) {
              child = Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
            } else {
              if (snapshot.hasData) {
                LoanListItem loanListitem;
                loanListitem = snapshot.data;
               var  loans = loanListitem.lOANINFORMATIONLIST!;
                child = Container(
                  child: ListView.builder(
                    itemCount:loans.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         // EmailDetailsScreen(
                            //         //     emailSubscription: emails[index]),
                            //   ),
                            // );
                          },
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Loan ID:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(loans[index].loanID!),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'OutstandingPrincipal:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("${loans[index].outstandingPrincipal.toStringAsFixed(2)},"),
                                    ],
                                  )),Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Dispersed Amount:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("${loans[index].dispersedAmount},"),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:

                                    // LoanID
                                    // ,DispersedAmount
                                    // ,OutstandingPrincipal
                                    // ,OutstandingInterest
                                    // ,RepaymentFrequency
                                    // ,InstallmentAmount
                                    // ,InstallmentStartDate
                                    // ,ValueDate
                                    // ,MaturityDate
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Outstanding Interest:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        " ${loans[index].outstandingInterest.toStringAsFixed(2)}",
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Installment Amount:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        " ${loans[index].installmentAmount.toStringAsFixed(2)}'",
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Divider())
                            ],
                          ));
                    },
                  ),
                );
              } else {
                child = Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            return child;
          },
        ),



    );
  }
}



class EmailsList {
}

