import 'package:flutter/material.dart';

class InfoBox {
  final String title;
  final String description;

  InfoBox({required this.title, required this.description});
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            infoBox.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            infoBox.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
