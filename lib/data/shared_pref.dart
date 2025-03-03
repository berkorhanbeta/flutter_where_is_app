import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whereis/data/model/item_model.dart';
import 'package:whereis/modules/controller/home_controller.dart';

class SharedPref {

  Future<void> saveItems(List<ItemModel> items) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // Creating JSON string for saving the items.
    List<String> nItems = items.map((v) => jsonEncode(v.toJson())).toList();
    await pref.setStringList('items', nItems);
  }

  Future<List<ItemModel>> getItems() async {
    List<ItemModel> items = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getStringList('items') != null){
      // Creating our item list from JSON String.
      items = (jsonDecode(pref.getStringList('items').toString()) as List).map(
              (v) => ItemModel.fromJson(v)).toList();
    }
    return items;
  }

  Future<void> addNewItem(ItemModel item, BuildContext context) async {
    List<ItemModel> items = await getItems();
    item.id = items.length; // Creating ID number for Item.
    items.add(item); // Adding to the list.
    await saveItems(items); // Saving our new item list.
    Provider.of<HomeController>(context, listen: false).getItems(); // Refreshing our app data.
  }


}