class SO {
  String? status;
  String? message;
  String? formID;
  var nextFormSequence;
  var backStack;
  List<ResultsData>? resultsData;
  List<SILIST>? sILIST;

  SO(
      {this.status,
        this.message,
        this.formID,
        this.nextFormSequence,
        this.backStack,
        this.resultsData,
        this.sILIST});

  SO.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    formID = json['FormID'];
    nextFormSequence = json['NextFormSequence'];
    backStack = json['BackStack'];
    if (json['ResultsData'] != null) {
      resultsData = <ResultsData>[];
      json['ResultsData'].forEach((v) {
        resultsData!.add(new ResultsData.fromJson(v));
      });
    }
    if (json['SILIST'] != null) {
      sILIST = <SILIST>[];
      json['SILIST'].forEach((v) {
        sILIST!.add(new SILIST.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['FormID'] = this.formID;
    data['NextFormSequence'] = this.nextFormSequence;
    data['BackStack'] = this.backStack;
    if (this.resultsData != null) {
      data['ResultsData'] = this.resultsData!.map((v) => v.toJson()).toList();
    }
    if (this.sILIST != null) {
      data['SILIST'] = this.sILIST!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsData {
  String? controlID;
  String? controlValue;

  ResultsData({this.controlID, this.controlValue});

  ResultsData.fromJson(Map<String, dynamic> json) {
    controlID = json['ControlID'];
    controlValue = json['ControlValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ControlID'] = this.controlID;
    data['ControlValue'] = this.controlValue;
    return data;
  }
}

class SILIST {
  var amount;
  String? frequency;
  String? noOfExecutions;
  String? firstExecutionDate;
  String? lastExecutionDate;
  String? creditAccountID;
  String? status;
  String? siID;
  String? reference;

  SILIST(
      {this.amount,
        this.frequency,
        this.noOfExecutions,
        this.firstExecutionDate,
        this.lastExecutionDate,
        this.creditAccountID,
        this.status, this.reference, this.siID});

  SILIST.fromJson(Map<String, dynamic> json) {
    amount = json['Amount'];
    frequency = json['Frequency'];
    noOfExecutions = json['No Of Executions'];
    firstExecutionDate = json['First Execution Date'];
    lastExecutionDate = json['Last Execution Date'];
    creditAccountID = json['Credit AccountID'];
    status = json['Status'];
    reference = json['ReferenceNo'];
    siID = json['SIID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Amount'] = this.amount;
    data['Frequency'] = this.frequency;
    data['No Of Executions'] = this.noOfExecutions;
    data['First Execution Date'] = this.firstExecutionDate;
    data['Last Execution Date'] = this.lastExecutionDate;
    data['Credit AccountID'] = this.creditAccountID;
    data['Status'] = this.status;
    return data;
  }
}
