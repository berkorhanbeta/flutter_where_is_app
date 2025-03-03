import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:whereis/modules/controller/home_controller.dart';
import 'package:whereis/screen/home/item/home_item.dart';
import 'package:whereis/utils/page_navigation.dart';

class HomeBottomSheet extends StatefulWidget {
  
  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setState(() {});
    return Consumer<HomeController>(
        builder: (context, controller, child) {
          final items = controller.items;
          if(items.isNotEmpty) {
            return Center(
              child: Container(
                margin: EdgeInsets.only(left: 10, bottom: 15, top: 15, right: 10),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            controller.deleteItem(int.parse(item.id.toString()));
                          });
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Icon(CupertinoIcons.delete),
                          padding: EdgeInsets.only(right: 20),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed(
                              PageNavigation.update_item,
                              parameters: {'id' : item.id.toString()}
                            );
                          },
                          child: HomeItem(item: item),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        }
    );
  }
}