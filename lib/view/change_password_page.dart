import 'package:Apti/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/colors/app_colors.dart';
import 'add_new_password_page.dart';

class ChangePasswordPage extends StatefulWidget {
  static const routeName = '/change_password_page';

  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController passwordController = TextEditingController();
  bool _isVisible = false;
  String? password = '';

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
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
        leading: const Icon(
          Icons.chevron_left_outlined,
          size: 35,
          color: AppColors.aptidarkblue2,
        ),
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
      body: Form(
        key: formKey,
        child: Column(
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
                  ),
                ),
              ),
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
      ),
    );
  }

  Widget _buildEpostaText() {
    return Padding(
      padding: const EdgeInsets.only(right: 300),
      child: Text(
        LocaleKeys.change_password_card_change_password_card_text.tr(),
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: AppColors.aptidarkblue5,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: SizedBox(
        width: 317,
        height: 50,
        child: TextFormField(
          obscureText: _isVisible ? false : true,
          controller: passwordController,
          validator: (value) {
            if (value!.length < 8) {
              return 'Password must be at least 7 characters long';
            } else {
              return null;
            }
          },
          onSaved: (value) => setState(() => password = value),
          keyboardType: TextInputType.visiblePassword,
          //obscureText: true,
          // validator: (value) {
          //   const pattern =
          //       r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
          //   final regExp = RegExp(pattern);

          //   if (value!.isEmpty) {
          //     return 'Lütfen şifre giriniz';
          //   } else if (!regExp.hasMatch(value)) {
          //     return 'Şifreniz 4 ile 15 karakter arasında olmalıdır.';
          //   } else {
          //     return null;
          //   }
          // },
          // onSaved: (value) => setState(() => password = value),
          // maxLength: 30,
          // onSaved: (value) => setState(() => username = value),

          // onChanged: (value) {
          //   setState(() {
          //     _btnActive = value.isNotEmpty ? true : false;
          //   });
          // },

          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  const BorderSide(color: AppColors.aptidarkgray5, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.aptidarkgray5, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: IconButton(
              color: AppColors.aptilightgray4,
              onPressed: updateStatus,
              icon: Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),

          //  keyboardType: TextInputType.visiblePassword,
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
        Navigator.of(context).pushNamed(AddNewPasswordPage.routeName);
        final isValid = formKey.currentState!.validate();
      },
      child: Text(
        LocaleKeys.change_password_card_change_password_button_text.tr(),
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

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 170),
          child: Text(
            LocaleKeys.change_password_card_change_password_card_title.tr(),
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: AppColors.aptidarkblue5,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(
          height: 17,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Apti üyeliğinizde kullanacağınız yeni şifrenizi belirleyin.',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.aptidarkblue5,
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
}
