part of craft_dynamic;

class PluginState extends ChangeNotifier {
  bool _loadingNetworkData = false;
  bool _obscureText = true;
  bool _deleteFormValues = true;
  bool _scanvalidationloading = false;
  String _currentTab = "";
  Widget? _logoutScreen;
  MenuType? _menuType;
  Color? _menuColor;
  final Map<String?, dynamic> _formInputValues = {};
  final Map<String?, dynamic> _encryptedFields = {};
  final Map<String?, dynamic> _screenDropDowns = {};
  final Map<String?, dynamic> _toAndFromAccounts = {};
  final Map<String, Map<String, dynamic>> _dynamicDropDownData = {};

  bool get loadingNetworkData => _loadingNetworkData;

  String get currentTab => _currentTab;

  bool get obscureText => _obscureText;

  bool get deleteFormInput => _deleteFormValues;

  bool get scanvalidationloading => _scanvalidationloading;

  Widget? get logoutScreen => _logoutScreen;

  MenuType? get menuType => _menuType;

  Color? get menuColor => _menuColor;

  Map<String?, dynamic> get formInputValues => _formInputValues;

  Map<String?, dynamic> get encryptedFields => _encryptedFields;

  Map<String?, dynamic> get screenDropDowns => _screenDropDowns;

  Map<String?, dynamic> get toAndFromAccounts => _toAndFromAccounts;

  Map<String, Map<String, dynamic>> get dynamicDropDownData =>
      _dynamicDropDownData;

  void setRequestState(bool state, {String? currentTab}) {
    _loadingNetworkData = state;
    _currentTab = currentTab ?? "";
    notifyListeners();
  }

  changeVisibility(bool visibility) {
    _obscureText = visibility;
    notifyListeners();
  }

  changeBiometricStatus(bool biometricStatus) {
    notifyListeners();
  }

  setDeleteForm(bool status) {
    _deleteFormValues = status;
    notifyListeners();
  }

  setLogoutScreen(Widget widget) {
    _logoutScreen = widget;
  }

  setMenuType(MenuType menuType) {
    _menuType = menuType;
  }

  setMenuColor(Color color) {
    _menuColor = color;
  }

  setScanValidationLoading(bool state) {
    _scanvalidationloading = state;
    notifyListeners();
  }

  addFormInput(Map<String?, dynamic> formInput) {
    _formInputValues.addAll(formInput);
    notifyListeners();
  }

  addEncryptedFields(Map<String?, dynamic> encryptedField) {
    _encryptedFields.addAll(encryptedField);
    notifyListeners();
  }

  addScreenDropDown(Map<String?, dynamic> screenDropDown) {
    _screenDropDowns.addAll(screenDropDown);
    notifyListeners();
  }

  setToAndFroAccount(Map<String?, dynamic> input) {
    _toAndFromAccounts.addAll(input);
    notifyListeners();
  }

  addDynamicDropDownData(Map<String, Map<String, dynamic>> data) {
    _dynamicDropDownData.addAll(data);
    notifyListeners();
  }

  clearDynamicInput() {
    _formInputValues.clear();
    _encryptedFields.clear();
    _screenDropDowns.clear();
    _toAndFromAccounts.clear();
    notifyListeners();
  }

  clearDynamicDropDown() {
    _dynamicDropDownData.clear();
    notifyListeners();
  }
}

class DynamicState extends ChangeNotifier {
  MenuScreenProperties? _menuScreenProperties;
  MenuProperties? _menuProperties;

  MenuScreenProperties? get menuScreenProperties => _menuScreenProperties;

  MenuProperties? get menuProperties => _menuProperties;

  setMenuScreen(MenuScreenProperties properties) {
    _menuScreenProperties = properties;
  }

  setMenuProperties(MenuProperties menuProperties) {
    _menuProperties = menuProperties;
  }
}

class DropDownState extends ChangeNotifier {
  bool _loadingFromAccounts = false;
  final Map<String?, dynamic> _currentSelections = {};
  final Map<String?, dynamic> _currentToAccountSelection = {};
  String _currentRelationID = "";
  final List<DropdownMenuItem<String>> _toAccountItems = [];
  final Map<String?, dynamic> _currentDropDownValue = {};

  bool get loadingFromAccounts => _loadingFromAccounts;

  Map<String?, dynamic>? get currentSelections => _currentSelections;

  List<DropdownMenuItem<String>> get toAccountItems => _toAccountItems;

  Map<String?, dynamic>? get currentToAccountSelection =>
      _currentToAccountSelection;

  String get currentRelationID => _currentRelationID;

  Map<String?, dynamic> get currentDropDownValue => _currentDropDownValue;

  setLoadingFromAccounts(bool status) {
    _loadingFromAccounts = status;
    notifyListeners();
  }

  setCurrentToAccountSelection(Map<String?, dynamic> value) {
    _currentToAccountSelection.addAll(value);
  }

  setCurrentSelections(Map<String?, dynamic> newSelection) {
    _currentSelections.addAll(newSelection);
    notifyListeners();
  }

  addCurrentRelationID(String id) {
    _currentRelationID = id;
    notifyListeners();
  }

  addCurrentDropDownValue(Map<String?, dynamic> value) {
    _currentDropDownValue.addAll(value);
    notifyListeners();
  }

  clearSelections() {
    _currentRelationID = "";
    _currentSelections.clear();
    _currentDropDownValue.clear();
  }
}

var currentToken = "".obs;

var showLoadingScreen = false.obs;

var isBiometricEnabled = false.obs;

var isCallingService = false.obs;

var currentStepperIndex = 0.obs;

var isStepperForm = false.obs;

var deleteFormInput = true.obs;

var selectedRadio = "".obs;

var currentIv = "".obs;
var currentKey = "".obs;

var previousIv = "".obs;
var previousKey = "".obs;

var currentBankID = "".obs;

var connectionState = ConnectivityResult.none.obs;

RxList<Map<String, dynamic>> currentLinkedValue = <Map<String, dynamic>>[].obs;

var isDeletingStandingOrder = false.obs;

var isGettingToken = false.obs;

var useExternalBankID = false.obs;

var lastWebHeaderUsed = "other".obs;

var showAccountBalanceInDropdowns = true.obs;

var accountsAndBalances = {}.obs;

var startenddate = {}.obs;

var dropdownSelection = {}.obs;
