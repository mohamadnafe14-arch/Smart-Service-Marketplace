import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        size: 40,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
