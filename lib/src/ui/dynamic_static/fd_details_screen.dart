import 'package:craft_dynamic/craft_dynamic.dart';
import 'package:flutter/material.dart';

class FDDetailsScreen extends StatelessWidget {
  final ModuleItem moduleItem;
  final _apiService = APIService();

  FDDetailsScreen({super.key, required this.moduleItem});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(moduleItem.moduleName)),
        body: FutureBuilder<DynamicResponse?>(
            future: _apiService.getListDetails(moduleItem.merchantID ?? ""),
            builder: (BuildContext context,
                AsyncSnapshot<DynamicResponse?> snapshot) {
              Widget child = CircularLoadUtil();
              if (snapshot.hasData) {
                var list = snapshot.data?.dynamicList ?? [];
                if (list.isNotEmpty) {
                  List<Map> items = [];

                  for (var item in list) {
                    items.add(item);
                  }

                  child = ListView.separated(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var mapItem = items[index];
                      mapItem.removeWhere(
                          (key, value) => key == null || value == null);

                      Map? firstMap = {};
                      Map? secondMap = {};

                      var length = mapItem.entries.length;
                      if (length >= 3) {
                        firstMap = Map.fromEntries(mapItem.entries.take(3));
                        secondMap = Map.fromEntries(mapItem.entries.skip(3));
                      } else {
                        firstMap = mapItem;
                      }

                      return ExpansionTile(
                        shape: InputBorder.none,
                        tilePadding: EdgeInsets.zero,
                        title: Container(
                            padding: EdgeInsets.zero,
                            child: Column(
                              children: firstMap
                                  .map((key, value) => MapEntry(
                                      key,
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  flex: 5,
                                                  child: Text("$key:",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14))),
                                              Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    value.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ))
                                            ],
                                          ))))
                                  .values
                                  .toList(),
                            )),
                        children: length > 3
                            ? secondMap
                                .map((key, value) => MapEntry(
                                    key,
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                flex: 5,
                                                child: Text("$key:",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))),
                                            Expanded(
                                                flex: 5,
                                                child: Text(
                                                  value.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ))
                                          ],
                                        ))))
                                .values
                                .toList()
                            : [],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.grey,
                    ),
                  );
                } else {
                  child = Center(
                    child: EmptyUtil(),
                  );
                }
              }
              return child;
            }),
      );
}
