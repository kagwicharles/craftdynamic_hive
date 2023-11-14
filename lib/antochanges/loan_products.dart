import 'package:craft_dynamic/antochanges/extensions.dart';
import 'package:craft_dynamic/antochanges/loan_products_item.dart';
import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:flutter/material.dart';

CommonSharedPref _sharedPrefs = CommonSharedPref();

class LoanProductsScreen extends StatefulWidget {
  final ModuleItem moduleItem;

  const LoanProductsScreen({super.key, required this.moduleItem});

  @override
  State<LoanProductsScreen> createState() => _LoanProductsScreenState();
}

class _LoanProductsScreenState extends State<LoanProductsScreen> {
  final _api = APIService();

  @override
  void initState() {
    fetchLoansDocument();
    super.initState();
  }

  Future<DynamicResponse?> fetchLoansDocument() async {
    DynamicResponse? dynamicResponse;
    dynamicResponse = await _api.fetchLoansDocument(widget.moduleItem);
    return dynamicResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Loan Products'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _api.getLoanProducts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Widget child = Center(
                    child: CircularLoadUtil(),
                  );
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.active) {
                    child = Center(child: CircularLoadUtil());
                  } else {
                    if (snapshot.hasData) {
                      LoanProducts loanProducts;
                      loanProducts = snapshot.data;
                      var loans = loanProducts.lOANPRODUCTS!;
                      child = ListView.separated(
                        itemCount: loans.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Loan ID:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(loans[index].loanProductID!),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Name:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text("${loans[index].loanProductName}"),
                                    ],
                                  ),
                                ],
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
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
            ),
            InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Loan products document",
                          style: TextStyle(color: APIService.appPrimaryColor),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: APIService.appPrimaryColor,
                        )
                      ],
                    )))
          ],
        ));
  }
}

class EmailsList {}
