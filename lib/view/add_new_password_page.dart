import 'package:apti_mobile/localization/locale_keys.g.dart';
import 'package:apti_mobile/view/change_pass_state_error_page.dart';
import 'package:apti_mobile/view/widgets/login_header.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

import '../core/colors/app_colors.dart';
import '../service/forgot_password_service.dart';
import 'change_pass_state_success_page.dart';

class AddNewPasswordPage extends StatefulWidget {
  //EasyLocalization

  static const routeName = '/add_new_password';

  const AddNewPasswordPage({Key? key}) : super(key: key);

  @override
  _AddNewPasswordPageState createState() => _AddNewPasswordPageState();
}

class _AddNewPasswordPageState extends State<AddNewPasswordPage> {
  var formKey = GlobalKey<FormState>();

  bool isValid = false;
  bool _isVisible = false;
  bool isLoading = false;
  var passwordController = TextEditingController();
  ForgotPasswordService? forgetPasswordService;
  final String baseUrl = 'http://api.test.apti.us';

  @override
  void initState() {
    forgetPasswordService =
        ForgotPasswordService(Dio(BaseOptions(baseUrl: baseUrl)));
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

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
      body: SingleChildScrollView(
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
      ),
    );
  }

  Widget _buildNameTextField() {
    return SizedBox(
      width: 311,
      height: 70,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: _isVisible ? false : true,
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Boş lan';
          }
          if (text.length < 4 || text.length > 15) {
            return LocaleKeys.login_validation_text_login_password_valid_text
                .tr();
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
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
        onChanged: (_) => setState(() {}),
        onEditingComplete: () => setState(() {
          isValid = !isValid;
        }),
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
      onPressed: isValid
          ? () async {
              // setState(() {
              //   isLoading = true;
              // });
              await forgetPasswordService!
                  .resetPasswd(
                      password: passwordController.text, c: "occa")
                  .then((value) async {
                    debugPrint("$value");
                if (value) {
                  // setState(() {
                  //   isLoading = false;
                  // });
                  Navigator.of(context)
                      .pushNamed(ChangePassSuccessPage.routeName);
                } else {
                  // setState(() {
                  //   isLoading = false;
                  // });
                  Navigator.of(context)
                      .pushNamed(ChangePassStatePage.routeName);
                }
              });
            }
          : null,
      child: Text(
        LocaleKeys.change_password_card_change_password_button_text.tr(),
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}
