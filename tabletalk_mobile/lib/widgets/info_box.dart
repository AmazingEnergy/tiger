import 'package:flutter/material.dart';
import 'package:tabletalk_mobile/core/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoBox {
  final String title;
  final String leftText;
  final String rightText;

  InfoBox({
    required this.title,
    required this.leftText,
    required this.rightText,
  });
}

class InfoBoxGrid extends StatelessWidget {
  final List<InfoBox> infoBoxes;

  InfoBoxGrid(this.infoBoxes);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: infoBoxes.length,
      itemBuilder: (context, index) {
        return InfoBoxWidget(infoBoxes[index]);
      },
    );
  }
}

class InfoBoxWidget extends StatelessWidget {
  final InfoBox infoBox;

  InfoBoxWidget(this.infoBox);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 51, 51, 51).withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        infoBox.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    infoBox.leftText,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    infoBox.rightText,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: -8,
            right: -8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  // Icon click logic here
                },
                child: SvgPicture.asset(
                  ImageConstant.imgIicon,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
