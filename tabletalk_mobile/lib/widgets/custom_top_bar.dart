// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'info_box.dart';

class CustomTopBar extends StatefulWidget {
  CustomTopBar({super.key, this.onChanged});

  Function(TopBarEnum)? onChanged;

  @override
  CustomTopBarState createState() => CustomTopBarState();
}

class CustomTopBarState extends State<CustomTopBar> {
  int selectedIndex = 0;

  List<TopMenuModel> topMenuList = [
    TopMenuModel(
      text: "Recipes",
      type: TopBarEnum.Recipes,
    ),
    TopMenuModel(
      text: "Restaurant",
      type: TopBarEnum.Restaurant,
    ),
  ];

  // Info boxes for Recipes
  List<InfoBox> recipesInfoBoxes = [
    InfoBox(title: 'Recipe Info 1', description: 'Recipe Description 1'),
    InfoBox(title: 'Recipe Info 2', description: 'Recipe Description 2'),
    // ... Add more later
  ];

  // Info boxes for Restaurant
  List<InfoBox> restaurantInfoBoxes = [
    InfoBox(
        title: 'Restaurant Info 1', description: 'Restaurant Description 1'),
    InfoBox(
        title: 'Restaurant Info 2', description: 'Restaurant Description 2'),
    // ... Add more later
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(topMenuList.length, (index) {
            return InkWell(
              onTap: () {
                selectedIndex = index;
                widget.onChanged?.call(topMenuList[index].type);
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  topMenuList[index].text,
                  style: TextStyle(
                    color: selectedIndex == index
                        ? const Color.fromRGBO(233, 30, 99, 1)
                        : appTheme.gray500,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: selectedIndex == index
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 16.0),
        if (topMenuList[selectedIndex].type == TopBarEnum.Recipes)
          InfoBoxGrid(recipesInfoBoxes),
        if (topMenuList[selectedIndex].type == TopBarEnum.Restaurant)
          InfoBoxGrid(restaurantInfoBoxes),
      ],
    );
  }
}

enum TopBarEnum {
  Recipes,
  Restaurant,
}

class TopMenuModel {
  TopMenuModel({
    required this.text,
    required this.type,
  });

  String text;

  TopBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
