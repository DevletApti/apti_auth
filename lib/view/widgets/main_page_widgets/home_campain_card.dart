import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';

class HomeCampainCard extends StatelessWidget {
  const HomeCampainCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.aptiwhite,
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              height: 303,
              width: 343,
              child: _buildCardCampain(context),
            ),
          ),
        ],
      ),
    );
  }
}

@override
Widget _buildCardCampain(BuildContext context) {
  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    color: AppColors.aptilightgray0,
    child: Column(
      children: [
        Image.asset('asset/image/main_card_image2.png'),
        const SizedBox(
          height: 5,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Pronet Kampanyasi',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Apti ve Pronet alarm sistemlerinden güvenlik kampanyası avantajlarla dolu.',
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Row(),
        const SizedBox(
          height: 25,
        ),
        _buildCampainBtn(),
      ],
    ),
  );
}




///
SizedBox _buildCampainBtn() {
  return SizedBox(
        height: 32,
        width: 309,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColors.aptiblueprimary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
          onPressed: () {},
          child: const Text('Katıl'),
        ),
      );
}
