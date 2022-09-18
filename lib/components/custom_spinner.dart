import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomSpinner extends StatefulWidget {
  const CustomSpinner({super.key});

  @override
  State<CustomSpinner> createState() => _CustomSpinnerState();
}

class _CustomSpinnerState extends State<CustomSpinner> {
  @override
  //More info => https://pub.dev/packages/flutter_spinkit
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SpinKitFoldingCube(itemBuilder: (BuildContext context, index) {
        return const DecoratedBox(decoration: BoxDecoration(color: Colors.red));
      }),
    );
  }
}
