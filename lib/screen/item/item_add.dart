import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:whereis/data/model/item_model.dart';
import 'package:whereis/data/shared_pref.dart';
import 'package:whereis/modules/controller/home_controller.dart';
import 'package:whereis/utils/images.dart';
import 'package:whereis/utils/page_navigation.dart';

class ItemAdd extends StatefulWidget {

  final String? itemId;
  const ItemAdd({super.key, this.itemId});

  @override
  State<ItemAdd> createState() => _ItemAddState();
}

class _ItemAddState extends State<ItemAdd> {
  String? address;
  double? iLat;
  double? iLong;
  TextEditingController name = new TextEditingController();
  TextEditingController hint = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isSelected = Images.car_1;

  @override
  Widget build(BuildContext context) {
    if(widget.itemId != null){
      loadData();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        leading: IconButton(
          icon: Icon(Icons.close_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                  child: GestureDetector(
                    onTap: () async {
                      isSelected = await Get.toNamed(PageNavigation.select_item_icon);
                      setState(() {
                        print('${isSelected}');
                      });
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: ClipOval(
                              child: Image.asset(isSelected),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Icon(Icons.edit, color: Colors.white),
                        )
                      ],
                    )
                  )
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Item\'s Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(CupertinoIcons.textformat_abc_dottedunderline),
                ),
                controller: name,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter the Item\'s name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Hint For Searching',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(CupertinoIcons.question_circle)
                ),
                controller: hint,
              ),
              SizedBox(height: 25),
              address == null
                  ? FilledButton.icon(
                  onPressed: () async {
                    final location = await Get.toNamed(PageNavigation.select_from_map);
                    setState(() {
                      address = location.formattedAddress;
                      iLat = location.latLng.latitude;
                      iLong = location.latLng.longitude;
                    });
                  },
                  label: Text('Select From Map'),
                  icon: Icon(CupertinoIcons.map_pin_ellipse),
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(20)
                  )
              ) : GestureDetector(
                onTap: () async {
                  final location = await Get.toNamed(PageNavigation.select_from_map);
                  setState(() {
                    address = location.formattedAddress;
                  });
                },
                child: Card(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.map_pin_ellipse),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${address}')
                              ],
                            ),
                          ),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    )
                ),
              ),
              SizedBox(height: 30),
              FilledButton.icon(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      if(address == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please select a location'))
                        );
                      } else {
                        saveItem();
                      }
                    }
                  },
                  label: Text('Save Item'),
                  icon: Icon(Icons.add_location_alt_outlined),
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(20)
                  )
              )
            ],
          ),
        ),
      )
    );
  }

  Future<void> saveItem() async {
    await SharedPref().addNewItem(
        ItemModel(
            0,
            isSelected,
            name.text,
            hint.text,
            address,
            iLat,
            iLong,
        ),
      context
    );
    Navigator.pop(context);
  }

  Future<void> loadData() async {
    ItemModel item = Provider.of<HomeController>(context, listen: false).getItem(int.parse(widget.itemId!));
    setState(() {
      address = item.address;
      iLat = item.lat;
      iLong = item.long;
      isSelected = item.icon!;
      name.text = item.name!;
      hint.text = item.hint.toString();
    });
  }
}