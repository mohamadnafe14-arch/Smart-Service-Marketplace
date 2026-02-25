import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class DifferentFormsLoginOrRegister extends StatelessWidget {
  final VoidCallback googleAuth, githubAuth;
  const DifferentFormsLoginOrRegister({
    super.key,
    required this.googleAuth,
    required this.githubAuth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          style: IconButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: googleAuth,
          icon: Icon(FontAwesomeIcons.google, color: Colors.red),
        ),
        IconButton(
          style: IconButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: githubAuth,
          icon: Icon(FontAwesomeIcons.github),
        ),
      ],
    );
  }
}