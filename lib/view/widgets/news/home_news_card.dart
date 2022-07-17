import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import '../../../core/colors/app_colors.dart';
import '../../../localization/locale_keys.g.dart';
import '../custom_app_bar.dart';

class HomeNewsCard extends StatelessWidget {
  const HomeNewsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(LocaleKeys.app_otp_otp_card_button.tr()),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          height: 152,
          width: 343,
          child: Card(
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: AppColors.aptilightgray2),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            color: AppColors.aptilightgray0,
            child: Row(
              children: [
                Image.asset('asset/image/news_card_image.png'),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: const TextSpan(
                          text: 'Satılık BMW 2010 80.000 ...KM',
                          style: TextStyle(
                              color: Color.fromARGB(255, 28, 35, 42),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const Text('data'),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 60),
                      child: Row(
                        children: const [
                          Text('2 saat önce',
                              style:
                                  TextStyle(color: AppColors.aptilightgray3)),
                          SizedBox(
                            width: 76,
                          ),
                          SizedBox(
                            width: 40,
                            height: 30,
                            child: Card(
                              color: AppColors.aptiblueprimary,
                              child: Padding(
                                padding: EdgeInsets.only(left: 6, top: 5),
                                child: Text(
                                  'Ilan',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.aptiwhite),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
