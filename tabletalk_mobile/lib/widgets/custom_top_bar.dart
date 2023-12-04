// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'info_box.dart';

class CustomTopBar extends StatefulWidget {
  CustomTopBar({
    Key? key,
    required this.onChanged,
    required this.menuItems,
    required this.recipeInfoBoxes,
    required this.restaurantInfoBoxes,
  }) : super(key: key);

  final Function(dynamic) onChanged;
  final List<TopMenuModel> menuItems;
  final List<InfoBox> recipeInfoBoxes;
  final List<InfoBox> restaurantInfoBoxes;

  @override
  CustomTopBarState createState() => CustomTopBarState();
}

class CustomTopBarState extends State<CustomTopBar> {
  int selectedIndex = 0;
  late List<InfoBox> currentInfoBoxes;

  @override
  void initState() {
    super.initState();
    // Set the initial InfoBoxes
    currentInfoBoxes = widget.recipeInfoBoxes;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _onMenuItemSelected(TopBarEnum.Item1);
                    },
                    child: buildMenuItem("Recipes", TopBarEnum.Item1),
                  ),
                ),
                buildVerticalLine(),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _onMenuItemSelected(TopBarEnum.Item2);
                    },
                    child: buildMenuItem("Restaurants", TopBarEnum.Item2),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          InfoBoxGrid(currentInfoBoxes),
        ],
      ),
    );
  }

  Widget buildMenuItem(String text, TopBarEnum type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: selectedIndex == menuIndex(type)
                  ? const Color.fromRGBO(233, 30, 99, 1)
                  : Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 2,
            width: 120,
            color: selectedIndex == menuIndex(type)
                ? const Color.fromRGBO(255, 142, 161, 1)
                : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget buildVerticalLine() {
    return Container(
      height: 30,
      width: 2,
      color: Colors.grey,
    );
  }

  int menuIndex(TopBarEnum type) {
    return widget.menuItems.indexWhere((item) => item.type == type);
  }

  void _onMenuItemSelected(TopBarEnum type) {
    setState(() {
      selectedIndex = menuIndex(type);
      widget.onChanged(type);
      currentInfoBoxes = (type == TopBarEnum.Item1)
          ? widget.recipeInfoBoxes
          : widget.restaurantInfoBoxes;
    });
  }
}

enum TopBarEnum {
  Item1,
  Item2,
}

class TopMenuModel {
  TopMenuModel({
    required this.text,
    required this.type,
  });

  String text;
  TopBarEnum type;
}
