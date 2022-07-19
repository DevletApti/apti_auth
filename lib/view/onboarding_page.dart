import 'package:Apti/core/colors/app_colors.dart';
import 'package:Apti/view/login_page.dart';
import 'package:Apti/view/widgets/onboarding_contents.dart';
import 'package:Apti/view/widgets/size_config.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "/onboarding";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  List colors = [
    const Color(0xffFFFFFF),
    const Color(0xffFFFFFF),
    const Color(0xffFFFFFF),
    const Color(0xffFFFFFF)
  ];

  Widget _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: AppColors.aptiblueprimary,
      ),

      //color: AppColors.aptilightgray2,
      margin: const EdgeInsets.only(right: 5),
      height: _currentPage == index ? 15 : 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 15 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    double blockH = SizeConfig.blockH!;
    double blockV = SizeConfig.blockV!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          Image.asset(
                            contents[i].image,
                            height: SizeConfig.blockV! * 35,
                          ),
                          SizedBox(
                            height: (height >= 840) ? 60 : 30,
                          ),
                          Text(
                            contents[i].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 30 : 35,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            contents[i].desc,
                            style: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w300,
                              fontSize: (width <= 550) ? 17 : 25,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (int index) => _buildDots(index: index),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: SizedBox(
                              width: 350,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(LoginPage.routeName);
                                },
                                child: const Text("Başla"),
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.aptiblueprimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: (width <= 550)
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 20)
                                      : EdgeInsets.symmetric(
                                          horizontal: width * 0.2,
                                          vertical: 25),
                                  textStyle: TextStyle(
                                      fontSize: (width <= 550) ? 13 : 17),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildNextBtn(width),
                              TextButton(
                                onPressed: () => _controller.jumpToPage(3),
                                child: const Text(
                                  "Atla",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: (width <= 550) ? 13 : 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextBtn(double width) {
    return SizedBox(
      width: 350,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          _controller.nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        child: const Text("Sonraki"),
        style: ElevatedButton.styleFrom(
          primary: AppColors.aptiblueprimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: (width <= 550)
              ? const EdgeInsets.symmetric(horizontal: 100, vertical: 20)
              : EdgeInsets.symmetric(horizontal: width * 0.2, vertical: 25),
          textStyle: TextStyle(fontSize: (width <= 550) ? 13 : 17),
        ),
      ),
    );
  }

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
}
