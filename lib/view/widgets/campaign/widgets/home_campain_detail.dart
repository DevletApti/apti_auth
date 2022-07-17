import 'package:flutter/material.dart';
import '../../../../core/colors/app_colors.dart';
import '../../custom_app_bar.dart';

class HomeCampainDetail extends StatelessWidget {
  final moonLanding = DateTime.utc(1969, 7, 20, 20, 18, 04);

  HomeCampainDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Kampanya Detayı'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('asset/image/campain_detail_image.png'),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 4, right: 2),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Pronet Kampanyasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 2),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Apti ve Pronet alarm sistemlerinden güvenlik kampanyası avantajlarla dolu.',
                textAlign: TextAlign.left,
              ),
            ),
          ),
          _buildDateSection(context),
          const SizedBox(
            height: 10,
          ),
          _buildCampaignHead(context),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 48,
            width: 327,
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
              child: const Text('Katil'),
            ),
          )
        ],
      ),
    );
  }
}

///
@override
Widget _buildDateSection(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 15, top: 12),
        child: Text('15 Nisan 2022 12:00'),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Container(
          width: 65,
          height: 24,
          child: const Padding(
            padding: EdgeInsets.only(left: 3, top: 5, bottom: 4, right: 2),
            child: Text(
              'Kampanya',
              style: TextStyle(fontSize: 12, color: AppColors.aptiwhite),
            ),
          ),
          //color: AppColors.apticolorpa3,
          decoration: const BoxDecoration(
            color: AppColors.aptiblueprimary,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
    ],
  );
}

///
@override
Widget _buildCampaignHead(BuildContext context) {
  return Column(
    children: const [
      Padding(
        padding: EdgeInsets.only(left: 16, bottom: 4, right: 2),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Kampanya Detayı ve Katılım Koşulları',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 16, right: 2),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tincidunt hendrerit nulla risus ultrices elementum in nunc, vestibulum phasellus. Fringilla leo integer mi pharetra. Turpis eu vitae eget vestibulum elit. Libero, potenti tristique scelerisque est consequat dolor. At dui mauris nulla urna morbi etiam sed. Elementum sed magna elit, tortor libero lorem id. Ullamcorper placerat diam tristique in. Quis maecenas quam faucibus etiam ullamcorper sit. Dis lobortis ante pulvinar nunc justo, pellentesque. Lobortis quis ',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    ],
  );
}

///    padding: const EdgeInsets.only(left: 7.0, top: 5.6, right: 6.0),