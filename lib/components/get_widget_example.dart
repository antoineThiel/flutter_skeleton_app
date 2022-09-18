import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class GetWidgetExample extends StatelessWidget {
  const GetWidgetExample({super.key, required this.btn1Fn, required this.btn2Fn});

  final VoidCallback btn1Fn;
  final VoidCallback btn2Fn;

  @override
  Widget build(BuildContext context) {
    return GFCard(
      image: Image.asset("assets/images/blue_picture.jpeg"),
      showImage: true,
      boxFit: BoxFit.cover,
      title: const GFListTile(
        avatar: GFAvatar(
          backgroundImage: AssetImage("assets/images/blue_picture.jpeg"),
        ),
        title: Text("Card Title"),
        subTitle: Text("Card Subitle"),
      ),
      content: const Text("Some quick example text to build on the card"),
      buttonBar: GFButtonBar(
        children: <Widget>[
          GFButton(
            onPressed: () async {
              btn1Fn();
            },
            text: "print camera permission",
          ),
          GFButton(
            onPressed: () async {
              btn2Fn();
            },
            text: 'Request camera permission',
          ),
        ],
      ),
    );
  }
}
