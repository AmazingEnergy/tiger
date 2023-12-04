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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
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
            ],
          ),
          Spacer(),
          // Title and Rating or Left Text and Right Text
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title or Left Text
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    infoBox.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1, // Set maxLines to 1
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(width: 8),
              // Rating or Right Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
          SizedBox(height: 4),
          // Left and Right Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                infoBox.leftText,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                maxLines: 1, // Set maxLines to 1
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                infoBox.rightText,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                maxLines: 1, // Set maxLines to 1
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
