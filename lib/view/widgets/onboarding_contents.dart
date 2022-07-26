import 'package:easy_localization/easy_localization.dart';

import '../../localization/locale_keys.g.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: LocaleKeys.onboard1.tr(),
    image: "asset/image/onboard1_image.png",
    desc: LocaleKeys.onboard1_description.tr(),
  ),
  OnboardingContents(
    title: LocaleKeys.onboard2.tr(),
    image: "asset/image/onboard2_image.png",
    desc:
       LocaleKeys.onboard2_description.tr(),
  ),
  OnboardingContents(
    title: LocaleKeys.onboard3.tr(),
    image: "asset/image/onboard3_image.png",
    desc:
         LocaleKeys.onboard3_description.tr(),
  ),
  OnboardingContents(
    title: LocaleKeys.onboard4.tr(),
    image: "asset/image/onboard4_image.png",
    desc:
        LocaleKeys.onboard4_description.tr(),
  ),
];
