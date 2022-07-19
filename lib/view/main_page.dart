import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/colors/app_colors.dart';

class MainPage extends StatefulWidget {
  static const routeName = "/main";

  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  static const List<Color> colors = [
    AppColors.aptiblueprimary,
    AppColors.aptiblueprimary,
    AppColors.aptiblueprimary,
    AppColors.aptiblueprimary,
    AppColors.aptiblueprimary
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        backgroundColor: AppColors.aptiwhite,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.chevron_right_outlined,
                  size: 30,
                  color: AppColors.aptidarkblue2,
                ),
                const SizedBox(width: 20),
                Image.asset('asset/image/main_page_notify_icon.png'),
              ],
            ),
          ),
        ],
        leading: Image.asset('asset/image/main_page_icon.png'),
        title: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 70),
              child: Text(
                'Mehmet Özer (2)',
                style: TextStyle(color: AppColors.aptidarkblue2, fontSize: 18),
              ),
            ),
            Text(
              'C-02/44 Başak Palace 3. Eta...',
              style: TextStyle(color: AppColors.aptidarkblue2, fontSize: 15),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Ana sayfa',
            icon: FaIcon(
              FontAwesomeIcons.house,
              //color: AppColors.aptilightgray4,
            ),
          ),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.bullhorn,
                //color: AppColors.aptilightgray4,
              ),
              label: 'Apti Club'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.clipboardList,
                //color: AppColors.aptilightgray4,
              ),
              label: 'Talepler'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.building,
                // color: AppColors.aptilightgray4,
              ),
              label: 'Dairem'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.user,
                //color: AppColors.aptilightgray4,
              ),
              label: 'Profil'),
        ],
        onTap: (value) => setState(() => _currentIndex = value),
        selectedItemColor: colors[_currentIndex],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: Padding(
      //           padding: EdgeInsets.only(top: 20),
      //           child: FaIcon(
      //             FontAwesomeIcons.house,
      //             color: AppColors.aptilightgray4,
      //           ),
      //         ),
      //         label: 'asd'),
      //     BottomNavigationBarItem(
      //       icon: FaIcon(
      //         FontAwesomeIcons.bullhorn,
      //         color: AppColors.aptilightgray4,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: FaIcon(
      //         FontAwesomeIcons.clipboardList,
      //         color: AppColors.aptilightgray4,
      //       ),
      //       label: 'asdas',
      //     ),
      //     BottomNavigationBarItem(
      //         icon: FaIcon(
      //           FontAwesomeIcons.building,
      //           color: AppColors.aptilightgray4,
      //         ),
      //         label: 'asd'),
      //     BottomNavigationBarItem(
      //         icon: FaIcon(
      //           FontAwesomeIcons.user,
      //           color: AppColors.aptilightgray4,
      //         ),
      //         label: 'asdasd'),
      //   ],
      // ),
      // ignore: sized_box_for_whitespace
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildReklamCard(),
            _buildAdvertImage(context),
            _buildCardCampain(context),
            _buildCardCampain(context),
            _buildReklamCard(),
            _buildAdvertImage(context),
            _buildAdvertImage(context),

            //   Text(widget.model?.token ?? 'null'),
            //_buildCardCampain(context),
          ],
        ),
      ),
    );
  }

  SizedBox _buildReklamCard() {
    return SizedBox(
      height: 160,
      width: 380,
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
                          style: TextStyle(color: AppColors.aptilightgray3)),
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
    );
  }
}

Widget _buildAdvertImage(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SizedBox(
      height: 160,
      width: 390,
      child: Image.asset(
        'asset/image/main_card_image8.png',
      ),
    ),
  );
}

@override
Widget _buildCardCampain(BuildContext context) {
  return SizedBox(
    width: 370,
    height: 303,
    child: Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      color: AppColors.aptilightgray2,
      child: Column(
        children: [
          Image.asset('asset/image/main_card_image7.png'),
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
    ),
  );
}

///
Widget _buildCampainBtn() {
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
