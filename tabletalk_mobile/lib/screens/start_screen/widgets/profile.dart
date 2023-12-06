// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

class Profile extends StatelessWidget {
  final UserProfile? user;
  Credentials? cre;

  Profile(this.user, this.cre, {final Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 214, 193, 254), width: 4),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(user?.pictureUrl.toString() ?? ''),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Welcome, ${user?.email}',
            style: const TextStyle(
              color: Color.fromARGB(255, 206, 109, 109),
              fontSize: 20,
            )),
        const SizedBox(height: 48),
      ],
    );
  }
}
