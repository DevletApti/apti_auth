import 'package:flutter/material.dart';

import '../model/register_response_model.dart';

class PasswordDView extends StatelessWidget {
  final RegisterResponseModel model;

  const PasswordDView({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(model.result.toString()),
          ],
        ),
      ),
    );
  }
}
