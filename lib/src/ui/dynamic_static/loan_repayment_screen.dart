import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class LoanRepaymentScreen extends StatefulWidget {
  final ModuleItem moduleItem;
  final String loanAcc;
  final String amount;

  const LoanRepaymentScreen(
      {super.key,
      required this.loanAcc,
      required this.amount,
      required this.moduleItem});

  @override
  State<LoanRepaymentScreen> createState() => _LoanRepaymentScreenState();
}

class _LoanRepaymentScreenState extends State<LoanRepaymentScreen> {
  final _profileRepo = ProfileRepository();
  List<BankAccount> userAccounts = [];
  final _formKey = GlobalKey<FormState>();
  final _api = APIService();

  final _loanAccController = TextEditingController();
  final _amountController = TextEditingController();
  final _narrController = TextEditingController();
  final _pinController = TextEditingController();

  bool _isLoading = true;
  String _currentValue = "";
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    autoPopulate();
    getBankAccounts();
  }

  autoPopulate() {
    if (widget.amount.isNotEmpty) {
      _amountController.text = widget.amount;
    }
    if (widget.loanAcc.isNotEmpty) {
      _loanAccController.text = widget.loanAcc;
    }
  }

  getBankAccounts() async {
    var accounts = await _profileRepo.getUserBankAccounts();
    setState(() {
      _isLoading = false;
      userAccounts = accounts;
      _currentValue = userAccounts[0].bankAccountId;
    });
  }

  String? inputValidator(String? value) {
    if (value != null && value.isEmpty) {
      return "Input required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Pay Loan")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    value: _currentValue,
                    items: userAccounts
                        .asMap()
                        .entries
                        .map((item) {
                          return DropdownMenuItem(
                            value: item.value.bankAccountId,
                            child: Text(
                              item.value.aliasName.isEmpty
                                  ? item.value.bankAccountId
                                  : item.value.aliasName,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          );
                        })
                        .toList()
                        .toSet()
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value.toString();
                      });
                    },
                    decoration: const InputDecoration(
                        label: Text("Select from Account")),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Input required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: _loanAccController,
                    decoration:
                        const InputDecoration(labelText: "Loan Account"),
                    validator: inputValidator,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: _amountController,
                    decoration: const InputDecoration(labelText: "Amount"),
                    validator: inputValidator,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _narrController,
                    decoration: const InputDecoration(labelText: "Narration"),
                    validator: inputValidator,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    obscureText: _isObscured,
                    controller: _pinController,
                    decoration: InputDecoration(
                        labelText: "Pin",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          icon: _isObscured
                              ? Icon(
                                  Icons.visibility,
                                  color: APIService.appPrimaryColor,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: APIService.appPrimaryColor,
                                ),
                        )),
                    validator: inputValidator,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  _isLoading
                      ? LoadUtil()
                      : ElevatedButton(
                          onPressed: payLoan, child: const Text("Pay Loan"))
                ],
              )),
        ),
      );

  showConfirmDialog() {
    return showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 4),
            decoration: const BoxDecoration(
                image: DecorationImage(
              opacity: .1,
              image: AssetImage(
                'assets/launcher.png',
              ),
            )),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Confirm Transaction",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(1);
                      },
                      child: const Row(
                          children: [Icon(Icons.close), Text("Cancel")]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                InputText(title: "From Account:", text: _currentValue),
                const SizedBox(
                  height: 12,
                ),
                InputText(title: "To Account:", text: _loanAccController.text),
                const SizedBox(
                  height: 12,
                ),
                InputText(title: "Amount:", text: _amountController.text),
                const SizedBox(
                  height: 12,
                ),
                InputText(title: "Narration:", text: _narrController.text),
                const Spacer(),
                SizedBox(
                    width: 300,
                    child: WidgetFactory.buildButton(context, () {
                      Navigator.of(context).pop(0);
                    }, "Continue".toUpperCase())),
                const SizedBox(
                  height: 44,
                )
              ],
            ));
      },
    );
  }

  payLoan() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await showConfirmDialog().then((value) {
        if (value == 0) {
          _api
              .repayLoan("LOANREPAYMENT",
                  fromAccount: _currentValue,
                  toAccount: _loanAccController.text,
                  amount: _amountController.text,
                  narration: _narrController.text,
                  pin: _pinController.text)
              .then((value) {
            setState(() {
              _isLoading = false;
            });
            if (value?.status == StatusCode.success.statusCode) {
              var builder = PostDynamicBuilder()
                ..receiptDetails = value?.receiptDetails;

              context.navigate(TransactionReceipt(
                  postDynamic: PostDynamic(builder, context, "")));
              // PDFUtil.downloadReceipt(
              //     receiptdetails: getTransactionDetailsMap(value!),
              //     isShare: false);
              // AlertUtil.showAlertDialog(context, value?.message ?? "",
              //         isInfoAlert: true, title: "Success")
              //     .then((value) {
              //   if (value) {
              //     Navigator.pop(context);
              //   }
              // });
            } else {
              AlertUtil.showAlertDialog(context, value?.message ?? "",
                  isInfoAlert: true, title: "Info");
            }
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } else {
      Vibration.vibrate();
    }
  }

  Map<String, dynamic> getTransactionDetailsMap(DynamicResponse postDynamic) {
    Map<String, dynamic> details = {};
    postDynamic.receiptDetails?.asMap().forEach((index, item) {
      String title = MapItem.fromJson(postDynamic.receiptDetails?[index]).title;
      String value =
          MapItem.fromJson(postDynamic.receiptDetails?[index]).value ?? "****";
      details.addAll({title: value});
    });
    return details;
  }
}

class InputText extends StatelessWidget {
  final String title;
  final String text;

  const InputText({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(text)
        ],
      );
}
