import 'package:flutter/material.dart';

import '../../../core/colors/app_colors.dart';

class HomeAnnonContent extends StatelessWidget {
  const HomeAnnonContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.aptiwhite,
      ),
      body: _builAnnonCard(context),
    );
  }
}


///Annoncment Card
Widget _builAnnonCard(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SizedBox(
      width: 342,
      height: 149,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        color: AppColors.aptiorange1,
        child: Column(
          children: [
            _buildAnonCardHeader(context),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Urna auctor eget pellentesque aenean.'),
            ),
            const SizedBox(height: 8),
            _buildDateAnnon()
          ],
        ),
      ),
    ),
  );
}

///
Widget _buildAnonCardHeader(BuildContext context) {
  return Padding(
    // икс запомни
    padding: const EdgeInsets.only(left: 16, top: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(Icons.electrical_services),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: EdgeInsets.only(right: 150),
          child: Text(
            'güç kesintisi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Icon(Icons.chevron_right),
      ],
    ),
  );
}

Widget _buildDateAnnon() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text('1 dk önce'),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          width: 50,
          height: 24,
          child: const Padding(
            padding: EdgeInsets.only(left: 4, top: 5, bottom: 4, right: 2),
            child: Text(
              'Duyuru',
              style: TextStyle(fontSize: 12, color: AppColors.aptiwhite),
            ),
          ),
          //color: AppColors.apticolorpa3,
          decoration: const BoxDecoration(
            color: AppColors.aptiorange3,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
    ],
  );
}
