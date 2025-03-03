import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whereis/data/model/item_model.dart';

class HomeItem extends StatelessWidget {
  final ItemModel item;
  const HomeItem({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(item.icon!, width: 50, height: 50),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${item.id} - ${item.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  SizedBox(
                    height: 5
                  ),
                  Text(
                    '${item.hint}',
                    style: TextStyle(
                      fontSize: 14
                    ),
                  ),
                  SizedBox(
                      height: 5
                  ),
                  Text(
                    '${item.address}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}