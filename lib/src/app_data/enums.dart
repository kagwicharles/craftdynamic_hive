// ignore_for_file: constant_identifier_names

part of craft_dynamic;

enum ViewType {
  TEXT,
  BUTTON,
  RBUTTON,
  DROPDOWN,
  TAB,
  LABEL,
  QRSCANNER,
  PHONECONTACTS,
  DATE,
  HIDDEN,
  LIST,
  TEXTVIEW,
  HYPERLINK,
  CONTAINER,
  SELECTEDTEXT,
  IMAGE,
  TITLE,
  FORM,
  OTHER,
  STEPPER,
  STEP,
  CHECKBOX,
  HORIZONTALTEXT,
  DYNAMICDROPDOWN,
  CAROUSELVIEW
}

enum ControlFormat {
  PinNumber,
  PIN,
  NUMERIC,
  Amount,
  DATE,
  imagepanel,
  HorizontalScroll,
  SELECTBANKACCOUNT,
  SELECTBENEFICIARY,
  LISTDATA,
  OTHER,
  OPENFORM,
  NEXT,
  RADIOGROUPS
}

enum DynamicDataType { Modules, ActionControls, FormControls }

enum ControlID {
  BANKACCOUNTID,
  BANKACCOUNTID1,
  BANKACCOUNTID2,
  BANKACCOUNTID3,
  BANKACCOUNTID4,
  BANKACCOUNTID5,
  BENEFICIARYACCOUNTID,
  OTHER,
  AMOUNT,
  BIBLELIST,
  TOACCOUNTID,
  SELECTTYPE
}

enum ActionType {
  DBCALL,
  ACTIVATIONREQ,
  PAYBILL,
  VALIDATE,
  LOGIN,
  CHANGEPIN,
  ACTIVATE,
  BENEFICIARY,
  CHANGELANGUAGE
}

enum ActionID { GETTRXLIST }

enum UserAccountData {
  FirstName,
  LastName,
  IDNumber,
  EmailID,
  ImageUrl,
  LastLoginDateTime,
  LoanLimit,
  Phone
}

enum RequestParam {
  FormID,
  SessionID,
  CustomerID,
  MobileNumber,
  Login,
  EncryptedFields,
  Activation,
  ModuleID,
  PayBill,
  UNIQUEID,
  BankID,
  Country,
  VersionNumber,
  IMEI,
  IMSI,
  TRXSOURCE,
  APPNAME,
  CODEBASE,
  LATLON,
  MerchantID,
  Validate,
  HEADER,
  DynamicForm,
  CHANGEPIN,
  CHANGELANGUAGE,
  Paybill,
}

enum FormFieldProp { ControlID, ControlValue }

enum ListType { TransactionList, ViewOrderList, BeneficiaryList }

enum ModuleId {
  DEFAULT,
  BOOKCAB,
  MERCHANTPAYMENT,
  GAS,
  DRINKS,
  TOPUPWALLET,
  SUPERMARKET,
  GROCERIES,
  PHARMACY,
  CAKE,
  FOOD,
  FINGERPRINT,
  TRANSACTIONSCENTER,
  PENDINGTRANSACTIONS,
  VIEWBENEFICIARY,
  STANDINGORDERVIEWDETAILS,
  PIN,
  LANGUAGEPREFERENCE,
  ADDBENEFICIARY
}

enum LittleProduct {
  Ride,
  PayMerchants,
  LoadWallet,
  Deliveries,
}

enum StatusCode {
  success("000"),
  failure("091"),
  token("099"),
  otp("093"),
  changeLanguage("094"),
  changePin("101"),
  unknown("XXXX");

  const StatusCode(this.statusCode);
  final String statusCode;
}

enum MenuCategory { BLOCK, FORM }

enum MenuType {
  VerticalPlain,
  VerticalOutlined,
  HorizontalPlain,
  HorizontalOutlined,
  DefaultMenuItem
}

enum ParentModule { MAIN, TRANSACTIONHISTORY, MYACCOUNTS }

enum RouteUrl { auth, account, card, other, staticdata }

enum FormId {
  STATICDATA,
  LOGIN,
  ACTIVATIONREQ,
  ACTIVATE,
  PAYBILL,
  MENU,
  FORMS,
  ACTIONS,
  ALERTCONFIRMATIONFORM,
  DBCALL
}

const success = "000";
const failure = "091";
const token = "099";
const otp = "093";
const changeLanguage = "094";
const changePin = "101";
const unknown = "xxx";
