part of craft_dynamic;

class DeviceInfo {
  static getDeviceUniqueID() async {
    if (kIsWeb) {
      return "123";
    }
    return await UniqueIdentifier.serial;
  }

  static performDeviceSecurityScan(bool enableEmulatorCheck) async {
    if (await _checkDeviceRooted()) {
      Fluttertoast.showToast(
          msg: "This app cannot work on rooted device!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Future.delayed(const Duration(seconds: 5), () {
        exit(0);
      });
    }
    if (enableEmulatorCheck && isEmulator()) {
      Fluttertoast.showToast(
          msg: "This app cannot work on an emulator!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Future.delayed(const Duration(seconds: 5), () {
        exit(0);
      });
    }
  }

  static Future<bool> _checkDeviceRooted() async {
    bool jailBroken = false;
    try {
      jailBroken = await RootChecker.isDeviceRooted();
      AppLogger.appLogD(tag: "check device rooted status", message: jailBroken);
    } on PlatformException {
      jailBroken = true;
    }
    return jailBroken;
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static bool isEmulator() {
    if (Platform.isAndroid) {
      return (Platform.environment['ANDROID_EMULATOR'] == '1') ||
          (Platform.isAndroid && !isPhysicalDevice);
    } else if (Platform.isIOS) {
      return (Platform.environment['SIMULATOR_DEVICE_NAME'] != null) ||
          (Platform.isIOS && !isPhysicalDevice);
    }
    return false;
  }

  static bool get isPhysicalDevice => !Platform.isAndroid && !Platform.isIOS;
}
