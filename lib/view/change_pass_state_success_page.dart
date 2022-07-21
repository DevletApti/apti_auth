import 'package:apti_mobile/localization/locale_keys.g.dart';
import 'package:apti_mobile/view/login_page.dart';
import 'package:apti_mobile/view/widgets/login_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassSuccessPage extends StatefulWidget {
  static const routeName = '/change_page_state_success_page';
  const ChangePassSuccessPage({Key? key}) : super(key: key);

  @override
  _ChangePassSuccessPageState createState() => _ChangePassSuccessPageState();
}

class _ChangePassSuccessPageState extends State<ChangePassSuccessPage> {
  // ScreenUtil().setWidth(17),
  //ScreenUtil().setHeight(16),

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(305, 785));
    return Scaffold(
      backgroundColor: AppColors.aptiwhite,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: ScreenUtil().setHeight(85.0),
        backgroundColor: AppColors.aptiwhite,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: const [],
            ),
          ),
        ],
        leading: const Text(''),
        title: Column(
          children: const [
            HeaderWidget(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(50),
                  left: ScreenUtil().setWidth(16),
                  right: ScreenUtil().setWidth(16)),
              child: SizedBox(
                width: ScreenUtil().setWidth(340),
                height: ScreenUtil().setHeight(260),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(14.0),
                      color: AppColors.aptilightgray0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setHeight(10),
                            ScreenUtil().setWidth(20),
                            ScreenUtil().setHeight(10),
                            ScreenUtil().setHeight(10)),
                        child: SizedBox(
                          width: ScreenUtil().setWidth(96),
                          height: ScreenUtil().setHeight(96),
                          child: Image.asset(
                              'asset/image/pass_success_state_icon.png'),
                        ),
                      ),
                      SizedBox(
                        // width: ScreenUtil().setWidth(10),
                        height: ScreenUtil().setHeight(20),
                      ),
                      Text(
                        LocaleKeys
                            .change_password_success_change_password_success_title
                            .tr(),
                        style: const TextStyle(
                            color: AppColors.aptilightgreen7,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(16)),
                      Text(LocaleKeys
                          .change_password_success_change_password_success_subtext
                          .tr()),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              // width: ScreenUtil().setWidth(10),
              height: ScreenUtil().setHeight(30),
            ),
            Container(
              width: ScreenUtil().setWidth(365),
              height: ScreenUtil().setHeight(50),
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setHeight(20),
                  ScreenUtil().setWidth(0),
                  ScreenUtil().setHeight(20),
                  ScreenUtil().setWidth(0)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: _buildButton(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColors.aptiblueprimary,
        onSurface: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(LoginPage.routeName);
      },
      child: Text(
        LocaleKeys.forgot_password_email_forget_card_button_text.tr(),
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
      // await _readCredentials();
      // const Duration(seconds: 2);
      //   code = ftController!.text +
      //       scController!.text +
      //       tdController!.text +
      //       frController!.text +
      //       fvController!.text +
      //       textEditingController!.text;
      //   const Duration(seconds: 1);
      //   debugPrint(attemptId);
      //   context
      //       .read<VerifyEmailCubit>()
      //       .service
      //       .verifyEmail(attemptId: attemptId!, code: code!)
      //       .then((value) async {
      //     await _checkVerify;
      //     debugPrint("verifyEmail -> ${value!.result}   AttemptId -> $attemptId ");
      //   });
      //   const Duration(milliseconds: 2);
      //   verifyEmail!
      //       ? Navigator.of(context)
      //           .pushNamed(EmailVerifyPage.routeName)
      //       : setState(() => isValid = false);
    );
  }
}
