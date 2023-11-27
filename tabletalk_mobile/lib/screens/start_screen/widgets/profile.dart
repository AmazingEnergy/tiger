import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

class Profile extends StatelessWidget {
  final UserProfile? user;
  Credentials? cre;

  Profile(this.user, this.cre, {final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(user?.pictureUrl.toString() ?? ''),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Token: ${user?.name}'),
        const SizedBox(height: 48),
      ],
    );
  }
}