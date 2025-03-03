import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:whereis/data/model/item_model.dart';
import 'package:whereis/data/shared_pref.dart';

class HomeController extends ChangeNotifier {

  Future<bool> findCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location Services is off in device's settings.
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Asking permission for location
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }


  List<ItemModel> items = [];
  Future<void> getItems() async {
    items = [];
    // Getting our items from Shared Preferences.
    items = await SharedPref().getItems();
    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    items.removeAt(id); // Remove selected item
    items.forEach((item) {
      if(item.id! > id){
        // Change other items id number.
        item.id = item.id!-1;
      }
    });
    await SharedPref().saveItems(items);
    await getItems();
    notifyListeners();
  }

  ItemModel getItem(int id) {
    return items[id];
  }
}