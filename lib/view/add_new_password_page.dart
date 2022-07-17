import 'package:Apti/localization/locale_keys.g.dart';
import 'package:Apti/view/widgets/login_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/colors/app_colors.dart';

class AddNewPasswordPage extends StatefulWidget {
  //EasyLocalization

  static const routeName = '/add_new_password';

  const AddNewPasswordPage({Key? key}) : super(key: key);

  @override
  _AddNewPasswordPageState createState() => _AddNewPasswordPageState();
}

class _AddNewPasswordPageState extends State<AddNewPasswordPage> {
  var formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.aptiwhite,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80.0,
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

  Widget _buildNameTextField() {
    return SizedBox(
      width: 311,
      height: 70,
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        // ignore: missing_return
        validator: (String? value) {
          if (value!.isEmpty) {
            return LocaleKeys.signin_validation_text_signin_password_valid_text
                .tr();
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: AppColors.aptiwhite,
          filled: true,
          hintText: LocaleKeys.signin_card_signin_password_inside_text.tr(),
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
        ),

        // obscureText: RegisterCubit.get(context).isPassword,
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

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 160),
          child: Text(
            LocaleKeys.change_password_card_change_password_card_title.tr(),
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
          padding: EdgeInsets.only(right: 70, left: 20),
          child: Text(
            'Apti üyeliğinizde kullanacağınız yeni şifrenizi belirleyin.',
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
}
