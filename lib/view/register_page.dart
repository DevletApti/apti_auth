import 'package:Apti/view/email_verify_page.dart';
import 'package:Apti/view/widgets/country_code_widget/intl_phone_field.dart';
import 'package:Apti/view/widgets/login_header.dart';
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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final String baseUrl = 'http://api.test.apti.us';

  String? _message = 'sdfsdf';
  bool _isVisible = false;
  bool? rememberMe = false;
  bool isLoading = false;

  bool? showErrorMessage = false;
  String? inputtedValue;
  bool _btnActive = false;
  String? username = '';
  String? surname = '';
  String? phone = '';
  String? email = '';
  String? password = '';

  getString(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _isFullyEnter() {
    setState(() {
      _message = "${nameController.text} Okey";
    });
  }

  void _clearNameTextField() {
    // Clear everything in the text field
    nameController.clear();
    // Call setState to update the UI
    setState(() {});
  }

  void _clearSurnameTextField() {
    // Clear everything in the text field
    surnameController.clear();
    // Call setState to update the UI
    setState(() {});
  }

  void _clearEmailTextField() {
    // Clear everything in the text field
    emailController.clear();
    // Call setState to update the UI
    setState(() {});
  }

  void _clearPhoneTextField() {
    // Clear everything in the text field
    phoneController.clear();
    // Call setState to update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SendEmailCubit(
        formKey,
        service: RegisterService(Dio(BaseOptions(baseUrl: baseUrl))),
      ),
      child: BlocConsumer<SendEmailCubit, SendEmailState>(
        listener: (context, state) {
          if (state is SendComplete) {
            if (state.isComplete) {
              //  CacheHelper.saveData(key: '', value: '').then((value) => null)
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
      key: _scaffoldKey,
      backgroundColor: AppColors.aptiwhite,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),

                // ignore: sized_box_for_whitespace
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

  // Widget _buildCheckBox() {
  //   return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //     Padding(
  //       padding: const EdgeInsets.only(bottom: 40),
  //       child: Checkbox(
  //           focusColor: AppColors.aptilightgray4,
  //           activeColor: AppColors.aptiblueprimary,
  //           value: rememberMe,
  //           onChanged: (newValue) {
  //             setState(() => rememberMe = newValue);
  //           }),
  //     ),
  //     const Expanded(
  //       child: Padding(
  //         padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
  //         child: Text(
  //           'Kişisel verileriniz Aydınlatma Metni kapsamında işlenmektedir. Kişisel Verilerin Korunması Politikasını, Gizlilik Politikasını, Kullanıcı Sözleşmesini ve Çerez Politikasını okudum ve kabul ediyorum.',
  //           maxLines: 4,
  //           overflow: TextOverflow.ellipsis,
  //           //textDirection: TextDirection.rtl,
  //           textAlign: TextAlign.justify,
  //         ),
  //       ),
  //     ),
  //   ]);
  // }

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

  // Widget _signInButton() {
  //   return SizedBox(
  //     height: 48,
  //     width: 369,
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         primary: AppColors.aptiblueprimary,
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(16),
  //           ),
  //         ),
  //       ),
  //       onPressed: _btnActive == true ? _isFullyEnter : null,
  //       child: const Text('Kayit ol'),
  //     ),
  //   );
  // }

  Widget _buildNameTextField() {
    return SizedBox(
      width: 317,
      height: 70,
      child: TextFormField(
        autofocus: false,
        controller: nameController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return LocaleKeys.signin_validation_text_signin_name_valid_text
                .tr();
          }
          return null;
        },
        // maxLength: 30,
        onSaved: (value) => setState(() => username = value),

        onChanged: (value) {
          setState(() {
            _btnActive = value.isNotEmpty ? true : false;
          });
        },

        ///sd_________________________************************************//
        // onChanged: (value) => setState(() => inputtedValue = value),

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
          // suffixIcon: IconButton(
          //   onPressed: cancelController.clear,
          //   icon: const Icon(Icons.clear),
          // ),
        ),
      ),
    );
  }

  Widget _buildSurnameTextField() {
    return SizedBox(
      width: 311,
      height: 70,
      child: Expanded(
        child: TextFormField(
          controller: surnameController,
          keyboardType: TextInputType.name,

          // ignore: missing_return
          validator: (String? value) {
            if (value!.isEmpty) {
              return LocaleKeys.signin_validation_text_signin_surname_valid_text
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
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
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
      ),
    );
  }

  Widget _buildPhonTextField() {
    return SizedBox(
      width: 311,
      height: 70,
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        // ignore: missing_return
        validator: (String? value) {
          if (value!.isEmpty) {
            return LocaleKeys.signin_validation_text_signin_phone_valid_text
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
      ),
    );
  }

  Widget _buildPasswordTextField() {
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
            borderSide: const BorderSide(color: AppColors.aptidarkgray5),
          ),
          border: OutlineInputBorder(
            // on error only
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
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
                    .read<SendEmailCubit>()
                    .service
                    .sendEmail(email: emailController.text)
                    .then((value) async {
                  SharedPreferences prefs = await _prefs;
                  debugPrint(
                      "${prefs.getString("attemptId")} this is from send email page");
                  prefs.setString("name", nameController.text);
                  prefs.setString("surname", surnameController.text);
                  prefs.setString("password", passwordController.text);
                  prefs.setString("phoneNumber", phoneController.text);
                });
                setState(() {
                  isLoading = false;
                });

                Navigator.of(context).pushNamed(EmailVerifyPage.routeName);
              },
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
            activeColor: AppColors.aptiblueprimary,
            value: rememberMe,
            onChanged: (newValue) {
              setState(() => rememberMe = newValue);
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






















// import 'package:Apti/core/colors/app_colors.dart';
// import 'package:Apti/core/init/cache/locale_manager.dart';
// import 'package:Apti/cubit/send_email_cubit.dart';
// import 'package:Apti/cubit/send_email_state.dart';
// import 'package:Apti/localization/locale_keys.g.dart';
// import 'package:Apti/view/email_verify_page.dart';
// import 'package:Apti/view/widgets/login_header.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:easy_localization/easy_localization.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../cubit/register_cubit.dart';
// import '../cubit/register_state.dart';
// import 'login_page.dart';

// class RegisterPage extends StatefulWidget {
//   //EasyLocalization

//   static const routeName = "/register_page.dart";

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   var formKey = GlobalKey<FormState>();

//   var nameController = TextEditingController();

//   var surnameController = TextEditingController();

//   var emailController = TextEditingController();

//   var passwordController = TextEditingController();

//   var phoneController = TextEditingController();

//   //final cancelController = TextEditingController();

//   bool? rememberMe = false;

//   void _clearNameTextField() {
//     // Clear everything in the text field
//     nameController.clear();
//     // Call setState to update the UI
//     setState(() {});
//   }

//   void _clearSurnameTextField() {
//     // Clear everything in the text field
//     surnameController.clear();
//     // Call setState to update the UI
//     setState(() {});
//   }

//   void _clearEmailTextField() {
//     // Clear everything in the text field
//     emailController.clear();
//     // Call setState to update the UI
//     setState(() {});
//   }

//   void _clearPhoneTextField() {
//     // Clear everything in the text field
//     phoneController.clear();
//     // Call setState to update the UI
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return MultiBlocProvider(
//       providers: [
//       create: (context) => SendEmailCubit(),
//       child: BlocConsumer<SendEmailCubit, SendEmailStates>(
//         listener: (context, state) {
//           if (state is SendEmailSuccessState) {
//             Navigator.of(context).pushNamed(EmailVerifyPage.routeName);
//           }
//         },
//       )
//       ]
    
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: AppColors.aptiwhite,
//             appBar: AppBar(
//               elevation: 0,
//               toolbarHeight: 80.0,
//               backgroundColor: AppColors.aptiwhite,
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: Row(
//                     children: const [],
//                   ),
//                 ),
//               ],
//               leading: const Text(''),
//               title: Column(
//                 children: const [
//                   HeaderWidget(),
//                 ],
//               ),
//             ),
//             body: Center(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // ignore: sized_box_for_whitespace
//                         Container(
//                           width: 360,
//                           height: 800,
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                                 side: const BorderSide(
//                                     color: AppColors.aptilightgray2)),
//                             color: AppColors.aptilightgray0,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SizedBox(height: height * 0.04),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(0, 0, 273, 10),
//                                   child: Text(
//                                       LocaleKeys.signin_card_signin_name.tr()),
//                                 ),
//                                 SizedBox(
//                                   width: 311,
//                                   height: 70,
//                                   child: TextFormField(
//                                     autofocus: false,
//                                     controller: nameController,
//                                     keyboardType: TextInputType.name,
//                                     // ignore: missing_return
//                                     validator: (String? value) {
//                                       if (value!.isEmpty) {
//                                         return LocaleKeys
//                                             .signin_validation_text_signin_name_valid_text
//                                             .tr();
//                                       }
//                                       return null;
//                                     },
//                                     onChanged: (value) {
//                                       setState(() {});
//                                     },
//                                     decoration: InputDecoration(
//                                       fillColor: AppColors.aptiwhite,
//                                       filled: true,
//                                       hintText: LocaleKeys
//                                           .signin_card_signin_name_inside_text
//                                           .tr(),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       border: OutlineInputBorder(
//                                         // on error only
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       suffixIcon: nameController.text.isEmpty
//                                           ? null
//                                           : IconButton(
//                                               onPressed: _clearNameTextField,
//                                               icon: const Icon(Icons.clear)),
//                                       // suffixIcon: IconButton(
//                                       //   onPressed: cancelController.clear,
//                                       //   icon: const Icon(Icons.clear),
//                                       // ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: height * 0.03),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(0, 0, 260, 10),
//                                   child: Text(LocaleKeys
//                                       .signin_card_signin_surname
//                                       .tr()),
//                                 ),
//                                 SizedBox(
//                                   width: 311,
//                                   height: 70,
//                                   child: Expanded(
//                                     child: TextFormField(
//                                       controller: surnameController,
//                                       keyboardType: TextInputType.name,

//                                       // ignore: missing_return
//                                       validator: (String? value) {
//                                         if (value!.isEmpty) {
//                                           return LocaleKeys
//                                               .signin_validation_text_signin_surname_valid_text
//                                               .tr();
//                                         }
//                                         return null;
//                                       },
//                                       onChanged: (value) {
//                                         setState(() {});
//                                       },
//                                       decoration: InputDecoration(
//                                         fillColor: AppColors.aptiwhite,
//                                         filled: true,
//                                         hintText: LocaleKeys
//                                             .signin_card_signin_surname_inside_text
//                                             .tr(),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           borderSide: const BorderSide(
//                                               color: Colors.grey),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           borderSide: const BorderSide(
//                                               color: Colors.grey),
//                                         ),
//                                         border: OutlineInputBorder(
//                                           // on error only
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           borderSide: const BorderSide(
//                                               color: Colors.grey),
//                                         ),
//                                         suffixIcon:
//                                             surnameController.text.isEmpty
//                                                 ? null
//                                                 : IconButton(
//                                                     onPressed:
//                                                         _clearSurnameTextField,
//                                                     icon: const Icon(
//                                                         Icons.clear)),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: height * 0.03),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(0, 0, 250, 10),
//                                   child: Text(
//                                       LocaleKeys.signin_card_signin_email.tr()),
//                                 ),
//                                 SizedBox(
//                                   width: 311,
//                                   height: 70,
//                                   child: TextFormField(
//                                     controller: emailController,
//                                     keyboardType: TextInputType.emailAddress,
//                                     // ignore: missing_return
//                                     validator: (String? value) {
//                                       if (value!.isEmpty) {
//                                         return LocaleKeys
//                                             .signin_validation_text_signin_email_valid_text
//                                             .tr();
//                                       }
//                                       return null;
//                                     },
//                                     onChanged: (value) {
//                                       setState(() {});
//                                     },
//                                     decoration: InputDecoration(
//                                       fillColor: AppColors.aptiwhite,
//                                       filled: true,
//                                       hintText: LocaleKeys
//                                           .signin_card_signin_email_inside_text
//                                           .tr(),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       border: OutlineInputBorder(
//                                         // on error only
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       suffixIcon: emailController.text.isEmpty
//                                           ? null
//                                           : IconButton(
//                                               onPressed: _clearEmailTextField,
//                                               icon: const Icon(Icons.clear)),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: height * 0.03),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(0, 0, 220, 10),
//                                   child: Text(LocaleKeys
//                                       .signin_card_sign_in_phone_number
//                                       .tr()),
//                                 ),
//                                 SizedBox(
//                                   width: 311,
//                                   height: 70,
//                                   child: TextFormField(
//                                     controller: phoneController,
//                                     keyboardType: TextInputType.phone,
//                                     // ignore: missing_return
//                                     validator: (String? value) {
//                                       if (value!.isEmpty) {
//                                         return LocaleKeys
//                                             .signin_validation_text_signin_phone_valid_text
//                                             .tr();
//                                       }
//                                       return null;
//                                     },
//                                     onChanged: (value) {
//                                       setState(() {});
//                                     },
//                                     decoration: InputDecoration(
//                                       fillColor: AppColors.aptiwhite,
//                                       filled: true,
//                                       hintText: LocaleKeys
//                                           .signin_card_sign_in_phone_number
//                                           .tr(),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       border: OutlineInputBorder(
//                                         // on error only
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       suffixIcon: phoneController.text.isEmpty
//                                           ? null
//                                           : IconButton(
//                                               onPressed: _clearPhoneTextField,
//                                               icon: const Icon(Icons.clear)),
//                                     ),
//                                     onFieldSubmitted: (value) {
//                                       if (formKey.currentState!.validate()) {
//                                         CacheHelper.saveData(
//                                             key: 'user_data',
//                                             value: [
//                                               nameController.text,
//                                               surnameController.text,
//                                               passwordController.text,
//                                               phoneController.text
//                                             ]);
//                                         // RegisterCubit.get(context).userRegister(
//                                         //   name: nameController.text,
//                                         //   surname: surnameController.text,
//                                         //   emailAddress: emailController.text,
//                                         //   password: passwordController.text,
//                                         //   phoneNumber: phoneController.text,
//                                         // );
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(height: height * 0.03),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(0, 0, 265, 10),
//                                   child: Text(LocaleKeys
//                                       .signin_card_signin_password
//                                       .tr()),
//                                 ),
//                                 SizedBox(
//                                   width: 311,
//                                   height: 70,
//                                   child: TextFormField(
//                                     controller: passwordController,
//                                     keyboardType: TextInputType.visiblePassword,
//                                     // ignore: missing_return
//                                     validator: (String? value) {
//                                       if (value!.isEmpty) {
//                                         return LocaleKeys
//                                             .signin_validation_text_signin_password_valid_text
//                                             .tr();
//                                       }
//                                       return null;
//                                     },
//                                     decoration: InputDecoration(
//                                       fillColor: AppColors.aptiwhite,
//                                       filled: true,
//                                       hintText: LocaleKeys
//                                           .signin_card_signin_password_inside_text
//                                           .tr(),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       border: OutlineInputBorder(
//                                         // on error only
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: const BorderSide(
//                                             color: Colors.grey),
//                                       ),
//                                       suffixIcon: InkWell(
//                                         onTap: () {
//                                           RegisterCubit.get(context)
//                                               .changePasswordVisibility();
//                                         },
//                                         child: Icon(
//                                           RegisterCubit.get(context).suffix,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ),

//                                     obscureText:
//                                         RegisterCubit.get(context).isPassword,
//                                   ),
//                                 ),
//                                 SizedBox(height: height * 0.03),
//                                 _buildCheckBox()
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: height * 0.04),
//                         ConditionalBuilder(
//                           condition: state is! RegisterLoadingState,
//                           builder: (BuildContext context) {
//                             return InkWell(
//                               onTap: () {
//                                 if (formKey.currentState!.validate()) {
//                                   SendEmailCubit.get(context).sendEmail(
//                                     email: emailController.text,
//                                   );
//                                 }
//                               },
//                               child: Container(
//                                 width: 343,
//                                 height: 48,
//                                 decoration: const BoxDecoration(
//                                   color: AppColors.aptiblueprimary,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(16)),
//                                 ),
//                                 child: Center(
//                                     child: Text(
//                                   LocaleKeys.signin_card_signin_page_button
//                                       .tr(),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                   ),
//                                 )),
//                               ),
//                             );
//                           },
//                           fallback: (BuildContext context) => Center(
//                             child: CircularProgressIndicator(
//                               color: AppColors.aptidarkblue3,
//                               backgroundColor:
//                                   AppColors.aptidarkblue3.withOpacity(0.3),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: height * 0.05),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               LocaleKeys.signin_card_signin_account_check_text
//                                   .tr(),
//                               style: const TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                             const SizedBox(
//                               child: Text(' '),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.of(context)
//                                     .pushNamed(LoginPage.routeName);
//                               },
//                               child: Text(
//                                 LocaleKeys
//                                     .signin_card_signin_page_enter_text_button
//                                     .tr(),
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   color: AppColors.aptidarkblue3,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCheckBox() {
//     return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Padding(
//         padding: const EdgeInsets.only(bottom: 40),
//         child: Checkbox(
//             focusColor: AppColors.aptilightgray4,
//             activeColor: AppColors.aptiblueprimary,
//             value: rememberMe,
//             onChanged: (newValue) {
//               setState(() => rememberMe = newValue);
//             }),
//       ),
//       _buildLicenseAccept(),
//     ]);
//   }

//   Widget _buildLicenseAccept() {
//     return Expanded(
//       child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
//           child: RichText(
//             text: const TextSpan(children: [
//               TextSpan(
//                 text: 'Kişisel verileriniz ',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//               ),
//               TextSpan(
//                 text: 'Aydınlatma Metni',
//                 style: TextStyle(
//                   color: AppColors.aptiblueprimary,
//                   decoration: TextDecoration.underline,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//                 // recognizer: TapGestureRecognizer()
//                 //   ..onTap = followLink,
//               ),
//               TextSpan(
//                 text: 'kapsamında işlenmektedir.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//               ),
//               TextSpan(
//                 text: 'Kişisel Verilerin Korunması Politikasını,',
//                 style: TextStyle(
//                   color: AppColors.aptiblueprimary,
//                   decoration: TextDecoration.underline,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//               TextSpan(
//                 text: 'Gizlilik Politikasını,',
//                 style: TextStyle(
//                   color: AppColors.aptiblueprimary,
//                   decoration: TextDecoration.underline,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//               TextSpan(
//                 text: 'Kullanıcı Sözleşmesini ',
//                 style: TextStyle(
//                   color: AppColors.aptiblueprimary,
//                   decoration: TextDecoration.underline,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//               TextSpan(
//                 text: 've',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//               ),
//               TextSpan(
//                 text: ' Çerez Politikasını',
//                 style: TextStyle(
//                   color: AppColors.aptiblueprimary,
//                   decoration: TextDecoration.underline,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//               TextSpan(
//                 text: 'okudum ve kabul ediyorum.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//               ),
//             ]),
//           )

//           // child: Text(
//           //   'Kişisel verileriniz Aydınlatma Metni kapsamında işlenmektedir. Kişisel Verilerin Korunması Politikasını, Gizlilik Politikasını, Kullanıcı Sözleşmesini ve Çerez Politikasını okudum ve kabul ediyorum.',

//           //   maxLines: 8,
//           //   overflow: TextOverflow.ellipsis,
//           //   //textDirection: TextDirection.rtl,
//           //   textAlign: TextAlign.justify,
//           // ),

//           ),
//     );
//   }
// }

