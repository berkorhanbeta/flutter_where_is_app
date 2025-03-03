import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whereis/data/model/item_model.dart';
import 'package:whereis/modules/controller/home_controller.dart';

class HomeMaps extends StatefulWidget {

  @override
  State<HomeMaps> createState() => _HomeMapsState();
}

class _HomeMapsState extends State<HomeMaps> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Position? currentPosition;
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
      stream: Geolocator.getPositionStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final position = snapshot.data!;
          currentPosition = position;
          if (mapController != null) {
            mapController!.animateCamera(
              CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
            );
          }

          return Consumer<HomeController>(
            builder: (context, controller, child) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 15.0,
                ),
                onMapCreated: (controller) {
                  mapController = controller;
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: {
                  Marker(
                    markerId: MarkerId('user_location'),
                    position: LatLng(position.latitude, position.longitude),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
                  ),
                  for(int i = 0; i<controller.items.length; i++)
                    getPoints(controller.items[i])
                },
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Marker getPoints(ItemModel item) {
    return Marker(
      markerId: MarkerId('${item.name}'),
      position: LatLng(item.lat!, item.long!),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      onTap: () {
        AlertDialog alert = AlertDialog(
          title: Text('${item.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address : ${item.address}'),
              Text('Hint: ${item.hint}')
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close')
            )
          ],
        );
        showDialog(context: context, builder: (context) {
          return alert;
        });
      }
    );
  }
}