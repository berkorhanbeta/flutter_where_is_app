import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';

class ItemLocation extends StatefulWidget {

  @override
  State<ItemLocation> createState() => _ItemLocationState();
}

class _ItemLocationState extends State<ItemLocation> {
  double userLat = 0;
  double userLong = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Item\'s Location'),
      ),
      body: PlacePicker(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        enableNearbyPlaces: false,
        apiKey: '<YOUR API KEY>',
        onPlacePicked: (LocationResult result) {
          // Returning selected location's Google Maps datas.
          Navigator.of(context).pop(result);
        },
        initialLocation: LatLng(userLat, userLong),
        searchInputConfig: const SearchInputConfig(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8
          ),
          autofocus: false,
        ),
        searchInputDecorationConfig: const SearchInputDecorationConfig(
          hintText: 'Location of your item..'
        ),
      ),
    );
  }

  Future<void> userLocation() async {
    // Getting User's Current Location.
    Position position = await Geolocator.getCurrentPosition();
    // Refreshing widget for changing the camera position.
    setState(() {
      userLat = position.latitude;
      userLong = position.longitude;
    });
  }
}