import 'package:Apti/localization/locale_keys.g.dart';
import 'package:Apti/view/login_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/colors/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  //EasyLocalization

  static const routeName = '/password_forget';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  void _clearEmailTextField() {
    // Clear everything in the text field
    emailController.clear();
    // Call setState to update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_outlined,
          ),
          iconSize: 35,
          color: AppColors.aptidarkblue2,
          onPressed: () {
            Navigator.of(context).pushNamed(LoginPage.routeName);
          },
        ),
        // leading: const Icon(
        //   Icons.chevron_left_outlined,
        //   size: 35,
        //   color: AppColors.aptidarkblue2,
        // ),
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Text(
                LocaleKeys.forgot_password_email_forget_password_appbar.tr(),
                style: const TextStyle(
                    color: AppColors.aptidarkblue2, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 24,
            ),
            child: SizedBox(
                width: 365,
                height: 243,
                child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(14.0),
                        color: AppColors.aptilightgray0),
                    child: Column(
                      children: [
                        _buildContent(context),
                        _buildEpostaText(),
                        _buildNameTextField(),
                      ],
                    ))),
          ),
          Container(
            width: 365,
            height: 50,
            margin: const EdgeInsets.only(
              top: 20,
              left: 24,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: _buildButton(context),
          )
        ],
      ),
    );
  }

  Widget _buildEpostaText() {
    return Padding(
      padding: const EdgeInsets.only(right: 260),
      child: Text(
        LocaleKeys.forgot_password_email_forget_card_email_text.tr(),
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return SizedBox(
      width: 311,
      height: 70,
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        // ignore: missing_return
        validator: (String? value) {
          if (value!.isEmpty) {
            return LocaleKeys.signin_validation_text_signin_email_valid_text
                .tr();
          }
          return null;
        },
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          fillColor: AppColors.aptiwhite,
          filled: true,
          hintText: LocaleKeys.signin_card_signin_email_inside_text.tr(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            // on error only
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          suffixIcon: emailController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: _clearEmailTextField,
                  icon: const Icon(Icons.clear)),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 200),
          child: Text(
            LocaleKeys.forgot_password_email_forget_card_title_text.tr(),
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(
          height: 17,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Şifrenizi yenilemek için e-posta adresinize bir link gelecektir. Gelen linke tıklayıp yeni şifrenizi belirleyebilirsiniz.',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
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
      onPressed: () {},
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
