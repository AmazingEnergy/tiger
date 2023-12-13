// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({Key? key, this.onChanged}) : super(key: key);

  final Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 1;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgClock,
      activeIcon: ImageConstant.imgClock,
      type: BottomBarEnum.Clock,
    ),
    BottomMenuModel(
      icon: ImageConstant.img40ToolbarSearch,
      activeIcon: ImageConstant.img40ToolbarSearch,
      type: BottomBarEnum.toolbarsearch,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUser,
      activeIcon: ImageConstant.imgUser,
      type: BottomBarEnum.User,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: appTheme.black9003f.withOpacity(0.3),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              -0.5,
            ),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: bottomMenuList.map((menu) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: menu.icon,
              height: 29.v,
              width: 33.h,
              color: appTheme.gray500,
            ),
            activeIcon: Container(
              decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder21,
              ),
              child: CustomImageView(
                imagePath: menu.activeIcon,
                height: 30.v,
                width: 50.h,
                color: theme.colorScheme.onPrimary,
                margin: EdgeInsets.only(
                  top: 4.v,
                  bottom: 6.v,
                ),
              ),
            ),
            label: '',
          );
        }).toList(),
        onTap: (index) {
          setState(() {
            selectedIndex = 1;
          });
          widget.onChanged?.call(bottomMenuList[index].type);
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Clock,
  toolbarsearch,
  User,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  final String icon;
  final String activeIcon;
  final BottomBarEnum type;
}
