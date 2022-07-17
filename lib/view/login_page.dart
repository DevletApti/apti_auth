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
  // EasyLocalization
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailAddressController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool _isVisible = false;
  bool obscure = true;
  bool isLoading = false;
  String accessToken = '';
  int userId = 0;

  readTokenAndId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("accessToken") != null) {
      setState(() => accessToken = prefs.getString("accessToken")!);
    }
    if (prefs.getInt("userId") != null) {
      setState(() => userId = prefs.getInt("userId")!);
    }
  }

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  final String baseUrl = 'http://api.test.apti.us';

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
      height: 49,
      child: TextFormField(
        controller: emailAddressController,
        validator: MultiValidator([
          RequiredValidator(
              errorText:
                  LocaleKeys.login_error_textbutton_login_isempty_text.tr()),
          EmailValidator(
              errorText:
                  LocaleKeys.login_validation_text_login_email_valid_text.tr())
        ]),
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
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return SizedBox(
      width: 311,
      height: 49,
      child: TextFormField(
        obscureText: _isVisible ? false : true,
        controller: passwordController,
        validator: (value) => (value ?? '').length > 5 ? null : '5 ten kucuk',
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
      ),
    );
  }

  Widget buildSubmit(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
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
                    .read<LoginCubit>()
                    .service
                    .userLogin(
                        emailAddress: emailAddressController.text,
                        password: passwordController.text)
                    .then((value) async {
                  await readTokenAndId();
                  debugPrint(
                      "${accessToken} and ${userId} this is from login page");

                  if (accessToken != '')
                    Navigator.of(context).pushNamed(MainPage.routeName);
                });
                setState(() {
                  isLoading = false;
                });
              },
              child: const Text('Sign in'),
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

 
  








// import 'package:Apti/view/forgot_password_page.dart';
// import 'package:Apti/view/register_page.dart';
// import 'package:Apti/view/widgets/login_header.dart';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import '../core/colors/app_colors.dart';
// import '../localization/locale_keys.g.dart';

// class LoginPage extends StatefulWidget {
//   static const routeName = "/login";

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   var formKey = GlobalKey<FormState>();

//   var emailController = TextEditingController();

//   var passwordController = TextEditingController();

//   void _clearEmailTextField() {
//     // Clear everything in the text field
//     emailController.clear();
//     // Call setState to update the UI
//     setState(() {});
//   }

//   void _clearPasswordTextField() {
//     // Clear everything in the text field
//     passwordController.clear();
//     // Call setState to update the UI
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: AppColors.aptiwhite,
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: 80.0,
//         backgroundColor: AppColors.aptiwhite,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: Row(
//               children: const [],
//             ),
//           ),
//         ],
//         leading: const Text(''),
//         title: Column(
//           children: const [
//             HeaderWidget(),
//           ],
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: formKey,
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.fromLTRB(5, 30, 5, 50),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: height * 0.03),
//                     // ignore: sized_box_for_whitespace
//                     Container(
//                       width: 380,
//                       height: 386,
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             side: const BorderSide(
//                                 color: AppColors.aptilightgray2)),
//                         color: AppColors.aptilightgray0,
//                         child: Column(
//                           children: [
//                             SizedBox(height: height * 0.04),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 0, 240, 10),
//                               child: Text(
//                                 LocaleKeys.login_card_login_card_title.tr(),
//                                 style: const TextStyle(
//                                     color: AppColors.aptidarkblue5,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ),
//                             SizedBox(height: height * 0.02),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 0, 252, 10),
//                               child: Text(
//                                 LocaleKeys.login_card_login_email.tr(),
//                                 style: const TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 311,
//                               height: 70,
//                               child: TextFormField(
//                                 controller: emailController,
//                                 keyboardType: TextInputType.emailAddress,
//                                 // ignore: missing_return
//                                 validator: (String? value) {
//                                   if (value!.isEmpty) {
//                                     return LocaleKeys
//                                         .signin_validation_text_signin_email_valid_text
//                                         .tr();
//                                   }
//                                   return null;
//                                 },
//                                 onChanged: (value) {
//                                   setState(() {});
//                                 },
//                                 decoration: InputDecoration(
//                                   fillColor: AppColors.aptiwhite,
//                                   filled: true,
//                                   hintText: LocaleKeys
//                                       .signin_card_signin_email_inside_text
//                                       .tr(),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     // on error only
//                                     borderRadius: BorderRadius.circular(5),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   suffixIcon: emailController.text.isEmpty
//                                       ? null
//                                       : IconButton(
//                                           onPressed: _clearEmailTextField,
//                                           icon: const Icon(Icons.clear)),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: height * 0.04),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 0, 265, 10),
//                               child: Text(
//                                 LocaleKeys.login_card_login_password.tr(),
//                                 style: const TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 311,
//                               height: 70,
//                               child: TextFormField(
//                                 controller: emailController,
//                                 keyboardType: TextInputType.emailAddress,
//                                 // ignore: missing_return
//                                 validator: (String? value) {
//                                   if (value!.isEmpty) {
//                                     return LocaleKeys
//                                         .signin_validation_text_signin_email_valid_text
//                                         .tr();
//                                   }
//                                   return null;
//                                 },
//                                 onChanged: (value) {
//                                   setState(() {});
//                                 },
//                                 decoration: InputDecoration(
//                                   fillColor: AppColors.aptiwhite,
//                                   filled: true,
//                                   hintText: LocaleKeys
//                                       .signin_card_signin_email_inside_text
//                                       .tr(),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     // on error only
//                                     borderRadius: BorderRadius.circular(5),
//                                     borderSide:
//                                         const BorderSide(color: Colors.grey),
//                                   ),
//                                   suffixIcon: emailController.text.isEmpty
//                                       ? null
//                                       : IconButton(
//                                           onPressed: _clearPasswordTextField,
//                                           icon: const Icon(Icons.clear)),
//                                 ),
//                               ),
//                             ),
//                             _buildForgetText(context),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
//                       child: nextButton(context),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 90, top: 16),
//                       child: _buildBottomTexts(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildForgetText(BuildContext context) {
//   return Expanded(
//     child: Padding(
//       padding: const EdgeInsets.only(left: 190, top: 30),
//       child: TextButton(
//         onPressed: () {
//           Navigator.of(context).pushNamed(ForgotPasswordPage.routeName);
//         },
//         child: Text(
//           LocaleKeys.login_card_login_forget_password_text.tr(),
//           style: const TextStyle(color: AppColors.aptilightblue2),
//         ),
//       ),
//     ),
//   );
// }

// Widget nextButton(BuildContext context) {
//   return SizedBox(
//     height: 48,
//     width: 343,
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         primary: AppColors.aptiblueprimary,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(16),
//           ),
//         ),
//       ),
//       onPressed: () {},
//       child: Text(LocaleKeys.login_button_login_button_text.tr()),
//     ),
//   );
// }

// Widget _buildBottomTexts(BuildContext context) {
//   return Row(
//     children: [
//       Text(
//         LocaleKeys.login_bottom_text_login_text.tr(),
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//       ),
//       TextButton(
//         style: TextButton.styleFrom(
//           primary: AppColors.aptiblueprimary,
//           textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         onPressed: () {
//           Navigator.of(context).pushNamed(RegisterPage.routeName);
//         },
//         child: Text(
//           LocaleKeys.login_button_login_text_button.tr(),
//         ),
//       ),
//     ],
//   );
// }




