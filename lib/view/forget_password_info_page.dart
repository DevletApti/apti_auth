import 'package:apti_mobile/localization/locale_keys.g.dart';
import 'package:apti_mobile/view/forgot_password_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import '../core/colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import 'add_new_password_page.dart';

class ForgotPasswordInfoPage extends StatefulWidget {
  //EasyLocalization

  static const routeName = '/password_forget_info';

  const ForgotPasswordInfoPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordInfoPageState createState() => _ForgotPasswordInfoPageState();
}

class _ForgotPasswordInfoPageState extends State<ForgotPasswordInfoPage> {
  final bool _customTileExpanded = false;
  static const double radius = 15;

  UniqueKey? keyTile;
  bool isExpanded = false;

  StreamSubscription? _sub;

  Future<void> initUniLinks() async {
    _sub = linkStream.listen((String? link) {
      if (link != null) {
        var uri = Uri.parse(link);
        debugPrint("$uri");
        Navigator.of(context).pushNamed(AddNewPasswordPage.routeName);
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(305, 785));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        backgroundColor: AppColors.aptiwhite,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: const [],
            ),
          ),
        ],
        leading: const Icon(
          Icons.chevron_left_outlined,
          size: 35,
          color: AppColors.aptidarkblue2,
        ),
        title: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setHeight(17)),
              child: Text(
                LocaleKeys.forgot_password_email_forget_password_appbar.tr(),
                style: const TextStyle(
                    color: AppColors.aptidarkblue2, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: const BorderSide(color: AppColors.aptilightgray2, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => isExpanded ? shrinkTile() : expandTile(),
                    child: _buildEpostaText(),
                  ),
                  buildText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEpostaText() {
    return const Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 20),
      child: Text(
        'Şifre Değişikliği Bağlantısı E-posta Adresinize Gönderildi!',
        textAlign: TextAlign.left,
        maxLines: 5,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildText(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'ex***@gmail.com adresinize bir e-posta gönderdik. E-posta adresinize gelen linke tıklayıp yeni şifrenizi belirleyebilirsiniz.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ),
            ExpansionTile(
              key: keyTile,
              initiallyExpanded: isExpanded,
              childrenPadding: const EdgeInsets.all(15).copyWith(top: 0),
              title: const Text(
                'E-posta ulaşmadı mı?',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.aptiblueprimary),
              ),
              children: [
                const Text(
                  '* Gönderdiğimiz e-posta "spam" klasörüne düşmüş olabilir.',
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text:
                          '* E-posta adresinizi doğru yazdığınızdan ve spam klasörünüzde ilgili e-postanın olmadığından eminseniz, şifre değişiklik e-postasının tekrar gönderilmesi için ',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'tıklayın.',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context)
                            .pushNamed(ForgotPasswordPage.routeName),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        decoration: TextDecoration.underline,
                        color: AppColors.aptiblueprimary,
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ],
        ),
      );
}

Widget _buildContent(BuildContext context) {
  return Column(
    children: const [
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: EdgeInsets.only(right: 100),
        child: Text(
          'Şifre Değişikliği Bağlantısı E-posta Adresinize Gönderildi!',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(
        height: 17,
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Şifrenizi yenilemek için e-posta adresinize bir link gelecektir. Gelen linke tıklayıp yeni şifrenizi belirleyebilirsiniz.',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );
}




