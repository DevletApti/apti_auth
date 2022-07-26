import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
      child: SizedBox(
          width: 249,
          height: 45,
          child: Image.asset('asset/image/main_logo.png')),
    );
  }
}
