import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:whereis/modules/controller/home_controller.dart';
import 'package:whereis/screen/home/widget/home_bottom_sheet.dart';
import 'package:whereis/screen/home/widget/home_maps.dart';
import 'package:whereis/utils/page_navigation.dart';
import 'package:whereis/widgets/expandable_menu,.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Where Is'),
          ),
          body: FutureBuilder<bool>(
            future: controller.findCurrentPosition(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.data!) {
                return Center(child: Text('Permission Denied or Location Disabled.'));
              }
              return HomeMaps();
            },
          ),
          floatingActionButton: ExpandableMenu(
            distance: 100,
            children: [
              ActionButton(
                onPressed: () {
                  Get.toNamed(PageNavigation.add_item);
                },
                icon: Icon(CupertinoIcons.add),
                title: 'Add Item',
              ),
              ActionButton(
                onPressed: () {
                  if (controller.items.isEmpty) {
                    Get.snackbar('No items', 'You don\'t have any items yet.');
                  } else {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return HomeBottomSheet();
                        }
                    );
                  }
                },
                icon: Icon(CupertinoIcons.list_bullet),
                title: 'My Items',
              )
            ],
          ),
        );
      },
    );
  }
}