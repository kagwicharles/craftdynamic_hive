// ignore_for_file: must_be_immutable

import 'package:craft_dynamic/src/util/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:craft_dynamic/craft_dynamic.dart';

class ListWidget extends StatelessWidget {
  ListWidget(
      {Key? key,
      required this.scrollable,
      this.dynamicList = const [],
      this.summary = const [],
      this.controlID,
      this.serviceParamID,
      this.moduleItem})
      : super(key: key);

  final bool scrollable;
  String? controlID, serviceParamID;
  ModuleItem? moduleItem;
  List<dynamic>? dynamicList, summary;

  List<Map> mapItems = [];
  List<Map> summaryItems = [];

  @override
  Widget build(BuildContext context) {
    // return Text(jsonTxt!.toString());
    mapItems.clear();
    summaryItems.clear();

    if (dynamicList != null) {
      for (var item in dynamicList ?? []) {
        mapItems.add(item);
      }
    }

    if (summary != null) {
      for (var item in summary ?? []) {
        summaryItems.add(item);
      }
    }

    AppLogger.appLogD(tag: "summary list", message: summaryItems);

    return dynamicList != null && dynamicList!.isNotEmpty
        ? Column(children: [
            summaryItems.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Summary",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: summaryItems.length,
                          itemBuilder: (context, index) {
                            var mapItem = summaryItems[index];
                            mapItem.removeWhere(
                                (key, value) => key == null || value == null);
                            return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0, vertical: 0.0),
                                      child: Column(
                                        children: mapItem
                                            .map((key, value) => MapEntry(
                                                key,
                                                Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "$key:",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        Flexible(
                                                            child: Text(
                                                          value.toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: WidgetUtil
                                                                  .getTextColor(
                                                                      value
                                                                          .toString(),
                                                                      key.toString())),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ))
                                                      ],
                                                    ))))
                                            .values
                                            .toList(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    )
                                  ],
                                ));
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Theme.of(context).primaryColor.withOpacity(.6),
                        )
                      ],
                    ))
                : const SizedBox(),
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: mapItems.length,
              itemBuilder: (context, index) {
                var mapItem = mapItems[index];
                mapItem
                    .removeWhere((key, value) => key == null || value == null);
                return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                            child: InkWell(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 4.0),
                                  child: Column(
                                    children: mapItem
                                        .map((key, value) => MapEntry(
                                            key,
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "$key:",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                    Flexible(
                                                        child: Text(
                                                      value.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: WidgetUtil
                                                              .getTextColor(
                                                                  value
                                                                      .toString(),
                                                                  key.toString())),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ))
                                                  ],
                                                ))))
                                        .values
                                        .toList(),
                                  ),
                                ))),
                        const SizedBox(
                          height: 12,
                        )
                      ],
                    ));
              },
            ))
          ])
        : Center(
            child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "packages/craft_dynamic/assets/images/empty.png",
                height: 64,
                width: 64,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Nothing found!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: APIService.appPrimaryColor),
              )
            ],
          ));
  }
}
