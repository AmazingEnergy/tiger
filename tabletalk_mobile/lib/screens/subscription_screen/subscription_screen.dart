import 'package:flutter/material.dart';
import '../../core/utils/image_constant.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              ImageConstant.imgSubscription,
              height: 210,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildSectionTop(),
                  Expanded(
                    child: buildSectionBody(),
                  ),
                  buildSectionBottom(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTop() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Expanded(
                child: Text(
                  'TableTalk Premium +',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              'Get access to an unlimited amount of search and recommendations!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRow(
            'Free members',
            '2 searches per day\nGood search results with recommendation reasons\nDynamic feedback and rating',
            'Free',
            const Color(0xFFFD637C),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: const Divider(color: Colors.grey),
          ),
          buildRow(
            'Premium + members',
            'Membership history\n10 searches per day\nAccess to search history\nEnhance search results',
            '\$1.99',
            const Color(0xFFFD637C),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String heading, String bulletPoints, String column2Text,
      Color column2Color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
            color: Color(0xFFFD637C),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String bulletPoint in bulletPoints.split('\n'))
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '\u2022 ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            bulletPoint,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  column2Text,
                  style: TextStyle(
                    color: column2Color,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSectionBottom() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: InkWell(
        onTap: () {
          // logic
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFFFD637C), Color(0xFFFF8EA1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Center(
            child: Text(
              'Subscribe Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
