// ignore_for_file: must_be_immutable

part of craft_dynamic;

class ModuleItemWidget extends StatelessWidget {
  bool isMain = false;
  bool isSearch;
  ModuleItem moduleItem;

  ModuleItemWidget(
      {super.key,
      this.isMain = false,
      this.isSearch = false,
      required this.moduleItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<DynamicState>(builder: (context, state, child) {
      MenuProperties? menuProperties = moduleItem.menuProperties;

      MenuType getMenuType() {
        if (menuProperties?.axisDirection?.toUpperCase() == "HORIZONTAL") {
          return MenuType.Horizontal;
        }
        return MenuType.Vertical;
      }

      return GestureDetector(
          onTap: () {
            ModuleUtil.onItemClick(moduleItem, context);
          },
          child: IMenuUtil(getMenuType(), moduleItem).getMenuItem());
    });
  }
}

class VerticalModule extends StatelessWidget {
  ModuleItem moduleItem;

  VerticalModule({super.key, required this.moduleItem});

  @override
  Widget build(BuildContext context) {
    MenuProperties? menuProperties = moduleItem.menuProperties;
    MenuBorder? menuBorder = moduleItem.menuBorder;

    MainAxisAlignment getAlignment() {
      if (menuProperties?.alignment == "END") {
        return MainAxisAlignment.end;
      } else if (menuProperties?.alignment == "START") {
        return MainAxisAlignment.start;
      }
      return MainAxisAlignment.center;
    }

    return Card(
        surfaceTintColor:
            CommonUtils.parseColor(menuProperties?.backgroundColor ?? "#fffff"),
        elevation: menuProperties?.elevation ?? 0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: menuBorder?.width ?? 1.5,
                color: Theme.of(context).primaryColor.withOpacity(.7)),
            borderRadius: BorderRadius.all(
              Radius.circular(menuBorder?.radius ?? 12),
            )),
        child: Padding(
            padding: EdgeInsets.all(menuProperties?.padding ?? 4),
            child: Center(
              child: Column(
                mainAxisAlignment: getAlignment(),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MenuItemImage(
                    imageUrl: moduleItem.moduleUrl ?? "",
                    iconSize: menuProperties?.iconSize ?? 44,
                  ),
                  SizedBox(
                    height: double.parse(menuProperties?.spaceBetween ?? "12"),
                  ),
                  Flexible(
                      child: MenuItemTitle(
                    title: moduleItem.moduleName,
                    textSize: menuProperties?.textSize,
                    fontWeight:
                        menuProperties?.fontWeight?.toLowerCase() == "bold"
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ))
                ],
              ),
            )));
  }

  Color? getMenuColor(context) =>
      Provider.of<PluginState>(context, listen: false).menuColor;
}

class HorizontalModule extends StatelessWidget {
  ModuleItem moduleItem;

  HorizontalModule({
    super.key,
    required this.moduleItem,
  });

  @override
  Widget build(BuildContext context) {
    MenuProperties? menuProperties = moduleItem.menuProperties;
    MenuBorder? menuBorder = moduleItem.menuBorder;
    MainAxisAlignment getAlignment() {
      if (menuProperties?.alignment?.toUpperCase() == "END") {
        return MainAxisAlignment.end;
      } else if (menuProperties?.alignment?.toUpperCase() == "START") {
        return MainAxisAlignment.start;
      } else if (menuProperties?.alignment?.toUpperCase() == "CENTER") {
        return MainAxisAlignment.center;
      }
      return MainAxisAlignment.spaceBetween;
    }

    return Card(
        surfaceTintColor:
            CommonUtils.parseColor(menuProperties?.backgroundColor ?? "ffffff"),
        elevation: menuProperties?.elevation ?? 0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: menuBorder?.width ?? 1.5,
                color: CommonUtils.parseColor(menuBorder?.color ?? "#fffff")),
            borderRadius: BorderRadius.all(
              Radius.circular(menuBorder?.radius ?? 12),
            )),
        child: Padding(
            padding: EdgeInsets.all(menuProperties?.padding ?? 8),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: getAlignment(),
                children: [
                  MenuItemImage(
                    imageUrl: moduleItem.moduleUrl ?? "",
                    iconSize: menuProperties?.iconSize ?? 54,
                  ),
                  SizedBox(
                    width: double.parse(menuProperties?.spaceBetween ?? "12"),
                  ),
                  Flexible(
                      child: MenuItemTitle(
                    title: moduleItem.moduleName,
                    textSize: menuProperties?.textSize,
                    fontWeight:
                        menuProperties?.fontWeight?.toLowerCase() == "bold"
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ))
                ],
              ),
            )));
  }

  Color? getMenuColor(context) =>
      Provider.of<PluginState>(context, listen: false).menuColor;
}

class ModuleUtil {
  static final _dynamicRequest = DynamicFormRequest();

  static onItemClick(ModuleItem moduleItem, BuildContext context) {
    bool isDisabled = moduleItem.isDisabled ?? false;
    AppLogger.appLogD(
        tag: "click sensor", message: "module id --> ${moduleItem.moduleId}");

    if (isDisabled) {
      CommonUtils.showToast("Coming soon");
      return;
    }

    if (moduleItem.moduleId == "LOANPRODUCTS") {
      AppLogger.appLogD(
          tag: "module item", message: "module id LOANPRODUCTS clicked");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoanProductsScreen(
                moduleItem: moduleItem,
              )));
      return;
    }

    if (moduleItem.isBankCall ?? false) {
      CommonUtils.navigateToRoute(
          context: context,
          widget: const GlobalLoader(),
          isTransparentScreen: true);
      Map<String?, dynamic> dataObject = {};
      _dynamicRequest
          .dynamicRequest(moduleItem,
              dataObj: dataObject, url: 'account', action: ActionType.PAYBILL)
          .then((value) {
        Navigator.of(context).pop();
        DynamicPostCall.processDynamicResponse(
            value!.dynamicData!, context, null,
            moduleItem: moduleItem);
      });
      return;
    }

    if (moduleItem.isDBCall ?? false) {
      CommonUtils.navigateToRoute(
          context: context,
          widget: const GlobalLoader(),
          isTransparentScreen: true);
      Map<String?, dynamic> dataObject = {};
      dataObject.addAll({"HEADER": moduleItem.header});
      _dynamicRequest
          .dynamicRequest(moduleItem, dataObj: dataObject)
          .then((value) {
        Navigator.of(context).pop();
        DynamicPostCall.processDynamicResponse(
            value!.dynamicData!, context, null,
            moduleItem: moduleItem);
      });
      return;
    }

    switch (EnumFormatter.getModuleId(moduleItem.moduleId)) {
      // case ModuleId.PAYMERCHANT:
      //   {
      //     context.navigate(QRScanner(
      //       moduleItem: moduleItem,
      //       formItem: FormItem(
      //           controlType: '',
      //           controlText: '',
      //           controlId: 'VALIDATE1',
      //           actionId: 'VALIDATE1',
      //           moduleId: 'PAYMERCHANT',
      //           serviceParamId: 'ACCOUNTID'),
      //       context: context,
      //     ));
      //     break;
      //   }
      case ModuleId.FINGERPRINT:
        {
          CommonUtils.navigateToRoute(
              context: context, widget: const BiometricLogin());
          break;
        }
      case ModuleId.TRANSACTIONSCENTER:
        {
          getTransactionList(context, moduleItem);
          break;
        }
      case ModuleId.PENDINGTRANSACTIONS:
        {
          break;
        }
      case ModuleId.VIEWBENEFICIARY:
        {
          CommonUtils.navigateToRoute(
              context: context,
              widget: ViewBeneficiary(moduleItem: moduleItem));
          break;
        }
      case ModuleId.STANDINGORDERVIEWDETAILS:
        {
          CommonUtils.navigateToRoute(
              context: context,
              widget: ViewStandingOrder(moduleItem: moduleItem));
          break;
        }
      case ModuleId.LOANINFORMATION:
        {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoanListScreen()));
          break;
        }
      case ModuleId.BOOKCAB:
        {
          NativeBinder.invokeMethod(LittleProduct
              .Ride.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      case ModuleId.MERCHANTPAYMENT:
        {
          NativeBinder.invokeMethod(LittleProduct
              .PayMerchants.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      case ModuleId.TOPUPWALLET:
        {
          NativeBinder.invokeMethod(LittleProduct
              .LoadWallet.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      case ModuleId.FOOD:
        {
          NativeBinder.invokeMethod(LittleProduct
              .Deliveries.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      case ModuleId.PHARMACY:
        {
          NativeBinder.invokeMethod(LittleProduct
              .Deliveries.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      case ModuleId.SUPERMARKET:
        {
          NativeBinder.invokeMethod(LittleProduct
              .Deliveries.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      case ModuleId.GROCERIES:
        {
          NativeBinder.invokeMethod(LittleProduct
              .Deliveries.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      case ModuleId.GAS:
        {
          NativeBinder.invokeMethod(LittleProduct
              .Deliveries.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      case ModuleId.DRINKS:
        {
          NativeBinder.invokeMethod(LittleProduct
              .Deliveries.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      case ModuleId.CAKE:
        {
          NativeBinder.invokeMethod(LittleProduct
              .Deliveries.name); //Ride Deliveries LoadWallet PayMerchants
          break;
        }
      default:
        {
          CommonUtils.navigateToRoute(
              context: context,
              widget: DynamicWidget(
                moduleItem: moduleItem,
              ));
        }
    }
  }

  static getTransactionList(context, moduleItem) {
    CommonUtils.navigateToRoute(
        context: context, widget: TransactionList(moduleItem: moduleItem));
  }
}
