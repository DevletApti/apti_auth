import 'package:Apti/view/forgot_password_page.dart';
import 'package:Apti/view/main_page.dart';
import 'package:Apti/view/register_page.dart';
import 'package:Apti/view/widgets/login_header.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/colors/app_colors.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../localization/locale_keys.g.dart';
import '../service/login_service.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailAddressController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool _isVisible = false;
  bool obscure = true;
  bool isLoading = false;
  bool isValid = false;
  String accessToken = '';
  String refreshToken = '';

  final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      caseSensitive: false, multiLine: false);

  final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
      caseSensitive: false, multiLine: false);

  readTokenAndId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("accessToken") != null) {
      setState(() => accessToken = prefs.getString("accessToken")!);
    }
    if (prefs.getString("refreshToken") != null) {
      setState(() => refreshToken = prefs.getString("refreshToken")!);
    }
  }

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
  }

  final String baseUrl = 'http://default.api.test.apti.us';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        formKey,
        service: LoginService(Dio(BaseOptions(baseUrl: baseUrl))),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginComplete) {
            // Navigator.of(context).pushNamed(RegisterPage.routeName);
          }
        },
        builder: (context, state) {
          return _buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: autovalidateMode(state),
        child: SingleChildScrollView(
          //reverse: true,
          padding: const EdgeInsets.fromLTRB(5, 30, 5, 50),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const HeaderWidget(),
              const SizedBox(
                height: 70,
              ),
              Container(
                width: 340,
                height: 290,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border:
                      Border.all(color: AppColors.aptilightgray2, width: 2.0),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    _buildCardTitle(),
                    const SizedBox(height: 5),
                    _buildEmailTitle(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: _buildEmailTextField(),
                    ),
                    _buildPasswordTitle(),
                    const SizedBox(height: 12),
                    _buildPasswordTextField(),
                    _buildForgetText(context),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              buildSubmit(context),
              Padding(
                padding: const EdgeInsets.only(left: 90, top: 16),
                child: _buildBottomTexts(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return SizedBox(
      width: 311,
      height: 70,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: emailAddressController,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return LocaleKeys.login_error_textbutton_login_isempty_text.tr();
          }
          if (!emailRegExp.hasMatch(text)) {
            return LocaleKeys.login_validation_text_login_email_valid_text.tr();
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
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return SizedBox(
      width: 311,
      height: 70,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: _isVisible ? false : true,
        controller: passwordController,
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
      ),
    );
  }

  Widget buildSubmit(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(children: [
          Center(
            child: Visibility(
                visible: isLoading, child: const CircularProgressIndicator()),
          ),
          SizedBox(
            width: 342,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.aptiblueprimary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await context
                    .read<LoginCubit>()
                    .service
                    .userLogin(
                        emailAddress: emailAddressController.text,
                        password: passwordController.text)
                    .then((value) async {
                  await readTokenAndId();
                  debugPrint(
                      "AccessToken -> $accessToken  RefreshToken -> $refreshToken this is from login page");
                  debugPrint("$value this is value");
                });
                setState(() {
                  isLoading = false;
                });

                if (accessToken != '') {
                  Navigator.of(context).pushNamed(MainPage.routeName);
                } else {}
              },
              child: Text(LocaleKeys.login_button_login_button_text.tr()),
            ),
          ),
        ]);
      },
    );
  }
}

Widget _buildPasswordTitle() {
  return Padding(
    padding: const EdgeInsets.only(top: 17, right: 270),
    child: Text(
      LocaleKeys.login_card_login_password.tr(),
      style: const TextStyle(color: AppColors.aptidarkblue5),
    ),
  );
}

Widget _buildEmailTitle() {
  return Padding(
    padding: const EdgeInsets.only(top: 10, right: 260),
    child: Text(
      LocaleKeys.login_card_login_email.tr(),
      style: const TextStyle(color: AppColors.aptidarkblue5),
    ),
  );
}

Widget _buildCardTitle() {
  return Padding(
    padding: const EdgeInsets.only(top: 10, right: 255),
    child: Text(
      LocaleKeys.login_card_login_card_title.tr(),
      style: const TextStyle(
          color: AppColors.aptidarkgray5, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _buildForgetText(BuildContext context) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(left: 190, top: 30),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ForgotPasswordPage.routeName);
        },
        child: Text(
          LocaleKeys.login_card_login_forget_password_text.tr(),
          style: const TextStyle(color: AppColors.aptilightblue2),
        ),
      ),
    ),
  );
}

Widget _buildBottomTexts(BuildContext context) {
  return Row(
    children: [
      Text(
        LocaleKeys.login_bottom_text_login_text.tr(),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      TextButton(
        style: TextButton.styleFrom(
          primary: AppColors.aptiblueprimary,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(RegisterPage.routeName);
        },
        child: Text(
          LocaleKeys.login_button_login_text_button.tr(),
        ),
      ),
    ],
  );
}

AutovalidateMode autovalidateMode(LoginState state) => state
        is LoginValidateState
    ? (state.isValidate ? AutovalidateMode.always : AutovalidateMode.disabled)
    : AutovalidateMode.disabled;
