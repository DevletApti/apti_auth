import 'package:apti_mobile/view/email_verify_page.dart';
import 'package:apti_mobile/view/widgets/country_code_widget/intl_phone_field.dart';
import 'package:apti_mobile/view/widgets/login_header.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/colors/app_colors.dart';
import '../cubit/send_email_cubit.dart';
import '../cubit/send_email_state.dart';
import '../localization/locale_keys.g.dart';
import '../service/register_service.dart';
import 'login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String baseUrl = 'http://api.test.apti.us';

  final String? _message = 'sdfsdf';
  bool _isVisible = false;
  bool agree = false;
  bool isLoading = false;
  bool isButtonActive = false;
  bool isValid = false;
  bool? showErrorMessage = false;
  String? inputtedValue;
  String attemptId = '';
  bool isNotAvailableEmail = false;

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  readAttemptId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('attemptId') == null) {
      setState(() => attemptId = '');
    } else {
      setState(() => attemptId = prefs.getString('attemptId')!);
    }
  }

  saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  final nameRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]',
      caseSensitive: false, multiLine: false);

  final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      caseSensitive: false, multiLine: false);

  final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)',
      caseSensitive: false, multiLine: false);

  void _clearNameTextField() {
    nameController.clear();
    setState(() {});
  }

  void _clearSurnameTextField() {
    surnameController.clear();
    setState(() {});
  }

  void _clearEmailTextField() {
    emailController.clear();
    setState(() {});
  }

  void _clearPhoneTextField() {
    phoneController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 1060));

    return BlocProvider(
      create: (BuildContext context) => SendEmailCubit(
        formKey,
        service: RegisterService(Dio(BaseOptions(baseUrl: baseUrl))),
      ),
      child: BlocConsumer<SendEmailCubit, SendEmailState>(
        listener: (context, state) {
          if (state is SendComplete) {
            if (state.isComplete) {
            }
          }
        },
        builder: (context, state) {
          return _buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context, SendEmailState state) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: ScreenUtil().setHeight(80.0), //80.0
        backgroundColor: AppColors.aptiwhite,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setHeight(10)),
            child: Row(
              children: const [],
            ),
          ),
        ],
        leading: const Text(''),
        title: Column(
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 26, 0),
              child: HeaderWidget(),
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      backgroundColor: AppColors.aptiwhite,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: ScreenUtil().setHeight(15)),
                Container(
                  width: 370,
                  height: 790,
                  child: Card(
                    color: AppColors.aptilightgray0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side:
                            const BorderSide(color: AppColors.aptilightgray2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.02),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 260, 10),
                          child: Text(
                            LocaleKeys.signin_card_signin_card_title.tr(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 285, 10),
                          child: Text(
                            LocaleKeys.signin_card_signin_name.tr(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),

                        _buildNameTextField(),
                        SizedBox(height: height * 0.02),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 270, 10),
                          child: Text(
                            LocaleKeys.signin_card_signin_surname.tr(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        _buildSurnameTextField(),
                        SizedBox(height: height * 0.03),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 250, 10),
                          child: Text(
                            LocaleKeys.signin_card_signin_email.tr(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        _buildEmailTextField(),
                        SizedBox(height: height * 0.03),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 210, 5),
                          child: Text(
                            LocaleKeys.signin_card_sign_in_phone_number.tr(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        // _buildPhone(),
                        SizedBox(height: height * 0.02),
                        _buildPhonTextField(),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 265, 10),
                          child: Text(
                            LocaleKeys.signin_card_signin_password.tr(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),

                        _buildPasswordTextField(),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildCheckBox(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                buildSubmit(context),
                // _signInButton(),
                const SizedBox(
                  height: 25,
                ),
                _buildBottomTexts(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomTexts(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 120),
      child: Row(
        children: [
          Text(LocaleKeys.signin_card_signin_account_check_text.tr()),
          TextButton(
            style: TextButton.styleFrom(
              primary: AppColors.aptiblueprimary,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(LoginPage.routeName);
            },
            child: Text(
              LocaleKeys.signin_card_signin_page_enter_text_button.tr(),
            ),
          ),

          // Text(LocaleKeys.signin_card_signin_page_enter_text_button
          //   .tr())
        ],
      ),
    );
  }

  IntlPhoneField _buildPhone() {
    return IntlPhoneField(
      // ignore: deprecated_member_use
      searchText:
          LocaleKeys.signin_phone_code_select_sigin_search_field_text.tr(),
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      onChanged: (phone) {
        print(phone.completeNumber);
      },
      onCountryChanged: (country) {
        print('Country changed to: ' + country.name);
      },
    );
  }

  Widget _buildNameTextField() {
    return SizedBox(
      width: 317,
      height: 70,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: nameController,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Lütfen ad giriniz';
          }
          if (nameRegExp.hasMatch(text)) {
            return LocaleKeys.signin_validation_text_signin_name_valid_text
                .tr();
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: AppColors.aptiwhite,
          filled: true,
          hintText: LocaleKeys.signin_card_signin_name_inside_text.tr(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.aptidarkgray5),
          ),
          border: OutlineInputBorder(
            // on error only
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          suffixIcon: nameController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: _clearNameTextField,
                  icon: const Icon(Icons.clear)),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildSurnameTextField() {
    return SizedBox(
      width: 311,
      height: 70,
      child: Expanded(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: surnameController,
          keyboardType: TextInputType.name,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Lütfen soyad giriniz';
            }
            if (nameRegExp.hasMatch(text)) {
              return LocaleKeys.signin_validation_text_signin_surname_valid_text
                  .tr();
            }
            return null;
          },
          decoration: InputDecoration(
            fillColor: AppColors.aptiwhite,
            filled: true,
            hintText: LocaleKeys.signin_card_signin_surname_inside_text.tr(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: AppColors.aptidarkgray5),
            ),
            border: OutlineInputBorder(
              // on error only
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            suffixIcon: surnameController.text.isEmpty
                ? null
                : IconButton(
                    onPressed: _clearSurnameTextField,
                    icon: const Icon(Icons.clear)),
          ),
          onChanged: (_) => setState(() {}),
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
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Lütfen e-posta giriniz';
          }
          if (!emailRegExp.hasMatch(text)) {
            return LocaleKeys.signin_validation_text_signin_email_valid_text
                .tr();
          }
          if (isNotAvailableEmail) {
            return 'Email is not Available';
          }
          return null;
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
            borderSide: const BorderSide(color: AppColors.aptidarkgray5),
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
        onChanged: (_) => setState(() {
          if (isNotAvailableEmail) {
            isNotAvailableEmail = false;
          }
        }),
      ),
    );
  }

  Widget _buildPhonTextField() {
    return SizedBox(
      width: 311,
      height: 70,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: phoneController,
        keyboardType: TextInputType.phone,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Lütfen cep telefonu giriniz';
          }
          if (!phoneRegExp.hasMatch(text)) {
            return LocaleKeys.signin_validation_text_signin_phone_valid_text
                .tr();
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: AppColors.aptiwhite,
          filled: true,
          hintText: LocaleKeys.signin_card_sign_in_phone_number.tr(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.aptidarkgray5),
          ),
          border: OutlineInputBorder(
            // on error only
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          suffixIcon: phoneController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: _clearPhoneTextField,
                  icon: const Icon(Icons.clear)),
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
        controller: passwordController,
        obscureText: _isVisible ? false : true,
        keyboardType: TextInputType.visiblePassword,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Lütfen şifre giriniz';
          }
          if (text.length < 4 || text.length > 15) {
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
            borderSide: const BorderSide(color: AppColors.aptidarkgray5),
          ),
          border: OutlineInputBorder(
            // on error only
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
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
    return BlocConsumer<SendEmailCubit, SendEmailState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(children: [
          Visibility(
              visible: isLoading, child: const CircularProgressIndicator()),
          SizedBox(
            width: 360,
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
              onPressed: isValid
                  ? () async {
                      setState(() {
                        isLoading = true;
                      });
                      await context
                          .read<SendEmailCubit>()
                          .service
                          .sendEmail(email: emailController.text)
                          .then((value) async {
                        await readAttemptId();
                        debugPrint("$attemptId this is from send email page");
                        if (attemptId != '') {
                          await saveString("name", nameController.text);
                          await saveString("surname", surnameController.text);
                          await saveString("password", passwordController.text);
                          await saveString("phoneNumber", phoneController.text);
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context)
                              .pushNamed(EmailVerifyPage.routeName);
                        } else {
                          setState(() {
                            isLoading = false;
                            isNotAvailableEmail = true;
                          });
                        }
                      });
                    }
                  : null,
              child: const Text('Kayit ol'),
            ),
          ),
        ]);
      },
    );
  }

  Widget _buildCheckBox() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Checkbox(
            focusColor: AppColors.aptilightgray4,
            activeColor:
                agree ? AppColors.aptiblueprimary : AppColors.aptierrorred4,
            value: agree,
            onChanged: (value) {
              setState(() {
                agree = value ?? false;
                isValid = true;
              });
            }),
      ),
      _buildLicenseAccept(),
    ]);
  }

  Widget _buildLicenseAccept() {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: RichText(
            text: const TextSpan(children: [
              TextSpan(
                text: 'Kişisel verileriniz ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Aydınlatma Metni',
                style: TextStyle(
                  color: AppColors.aptiblueprimary,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                // recognizer: TapGestureRecognizer()
                //   ..onTap = followLink,
              ),
              TextSpan(
                text: 'kapsamında işlenmektedir.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Kişisel Verilerin Korunması Politikasını,',
                style: TextStyle(
                  color: AppColors.aptiblueprimary,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: 'Gizlilik Politikasını,',
                style: TextStyle(
                  color: AppColors.aptiblueprimary,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: 'Kullanıcı Sözleşmesini ',
                style: TextStyle(
                  color: AppColors.aptiblueprimary,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: 've',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ' Çerez Politikasını',
                style: TextStyle(
                  color: AppColors.aptiblueprimary,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: 'okudum ve kabul ediyorum.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ]),
          )),
    );
  }
}
