import 'package:flutter/material.dart';
import 'package:flutter_kit/user.model.dart';

class Home extends StatelessWidget {
  final User user;

  Home(this.user);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: Text(user.name,
                style:
                    TextStyle(decoration: TextDecoration.none, fontSize: 18))));
  }
}
