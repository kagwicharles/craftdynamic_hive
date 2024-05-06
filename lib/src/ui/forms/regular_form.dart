// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:provider/provider.dart';

class RegularFormWidget extends StatefulWidget {
  final ModuleItem moduleItem;
  final List<FormItem> sortedForms;
  final List<dynamic>? jsonDisplay, formFields;
  final bool hasRecentList;

  const RegularFormWidget(
      {super.key,
      required this.moduleItem,
      required this.sortedForms,
      required this.jsonDisplay,
      required this.formFields,
      this.hasRecentList = false});

  @override
  State<RegularFormWidget> createState() => _RegularFormWidgetState();
}

class _RegularFormWidgetState extends State<RegularFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  List<FormItem> formItems = [];
  FormItem? recentList;

  @override
  initState() {
    recentList = widget.sortedForms.toList().firstWhereOrNull(
        (formItem) => formItem.controlType == ViewType.LIST.name);
    checkIsChangePinForm(widget.moduleItem);
    super.initState();
  }

  checkIsChangePinForm(ModuleItem moduleItem) {
    AppLogger.appLogD(tag: "module id is-->", message: moduleItem.moduleId);
    if (moduleItem.moduleId == ModuleId.PIN.name) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AlertUtil.showAlertDialog(context,
            "Dear Customer, Please change your PIN for better security. Choose a new PIN and keep it private. We suggest our customers to change their pin periodically for enhanced security. \nThank you.");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    formItems = widget.sortedForms.toList()
      ..removeWhere((element) => element.controlType == ViewType.LIST.name);
    AppLogger.appLogD(
        tag: "regular form",
        message:
            "inputs ${Provider.of<PluginState>(context, listen: false).formInputValues}");

    return WillPopScope(
        onWillPop: () async {
          if (Provider.of<PluginState>(context, listen: false)
              .loadingNetworkData) {
            CommonUtils.showToast("Please wait...");
            return false;
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<PluginState>(context, listen: false)
                .clearDynamicDropDown();
          });
          Provider.of<PluginState>(context, listen: false).clearDynamicInput();
          Provider.of<DropDownState>(context, listen: false).clearSelections();
          Provider.of<PluginState>(context, listen: false)
              .screenDropDowns
              .clear();
          Provider.of<PluginState>(context, listen: false)
              .setRequestState(false);
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 2,
              title: Text(widget.moduleItem.moduleName),
              actions: recentList != null
                  ? [
                      IconButton(
                          onPressed: () {
                            CommonUtils.navigateToRoute(
                                context: context,
                                widget: ListDataScreen(
                                    widget: DynamicListWidget(
                                            moduleItem: widget.moduleItem,
                                            formItem: recentList)
                                        .render(),
                                    title: widget.moduleItem.moduleName));
                          },
                          icon: const Icon(
                            Icons.view_list,
                            color: Colors.white,
                          ))
                    ]
                  : null,
            ),
            body: SizedBox(
                height: double.infinity,
                child: Scrollbar(
                    thickness: 6,
                    controller: _scrollController,
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Form(
                            key: _formKey,
                            child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    left: 18, right: 18, top: 8),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: formItems.length,
                                itemBuilder: (context, index) {
                                  return BaseFormComponent(
                                      formItem: formItems[index],
                                      moduleItem: widget.moduleItem,
                                      formItems: formItems,
                                      formKey: _formKey,
                                      child: IFormWidget(formItems[index],
                                              jsonText: widget.jsonDisplay,
                                              formFields: widget.formFields)
                                          .render());
                                }))
                      ],
                    ))))));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
