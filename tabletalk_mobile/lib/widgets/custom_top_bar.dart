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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.menuItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    selectedIndex = index;
                    widget.onChanged(widget.menuItems[index].type);
                    setState(() {
                      // Switch InfoBoxes based on the selected menu item
                      currentInfoBoxes =
                          (widget.menuItems[index].type == TopBarEnum.Item1)
                              ? widget.recipeInfoBoxes
                              : widget.restaurantInfoBoxes;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Text(
                      widget.menuItems[index].text,
                      style: TextStyle(
                        color: selectedIndex == index
                            ? const Color.fromRGBO(233, 30, 99, 1)
                            : Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: selectedIndex == index
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: selectedIndex == index
                            ? const Color.fromRGBO(233, 30, 99, 1)
                            : Colors.transparent,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          InfoBoxGrid(currentInfoBoxes), // Use the current InfoBoxes
        ],
      ),
    );
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
