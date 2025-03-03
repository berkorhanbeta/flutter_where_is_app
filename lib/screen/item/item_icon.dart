import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whereis/utils/images.dart';

class ItemIcon extends StatefulWidget {

  @override
  State<ItemIcon> createState() => _ItemIconState();
}

class _ItemIconState extends State<ItemIcon> {
  int isSelected = 999;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose an Icon'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                scrollDirection: Axis.vertical,
                itemCount: Images.iconList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: isSelected == index ? Colors.orangeAccent : Colors.blueGrey,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: ClipOval(
                            child: Image.asset(Images.iconList[index]),
                          ),
                        ),
                      ),
                    )
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 15),
          FilledButton.icon(
              onPressed: () async {
                Navigator.of(context).pop(Images.iconList[isSelected]);
              },
              label: Text('Select Icon'),
              icon: Icon(Icons.add_location_alt_outlined),
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(20)
              )
          ),
          SizedBox(height: 15),
        ],
      ),
    );

  }
}