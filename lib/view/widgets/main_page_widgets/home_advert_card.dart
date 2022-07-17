import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';

class HomeAdvertCard extends StatelessWidget {
  final VoidCallback onPressed;
  const HomeAdvertCard({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.aptiwhite,
      ),
      body: Container(
        child: _buildAdvertImage(context),
      ),
    );
  }
}

// Home page AdvertImage
@override
Widget _buildAdvertImage(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Image.asset('asset/image/main_card_image1.png',
        
        ),
      ],
    ),
  );
}
