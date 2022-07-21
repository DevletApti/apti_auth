import 'package:apti_mobile/cubit/verify_email_cubit.dart';
import 'package:apti_mobile/cubit/verify_email_state.dart';
import 'package:apti_mobile/localization/locale_keys.g.dart';
import 'package:apti_mobile/view/login_page.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/colors/app_colors.dart';
import '../service/register_service.dart';

class EmailVerifyPage extends StatefulWidget {
  static const routeName = '/emailVerify';
  const EmailVerifyPage({Key? key}) : super(key: key);
  @override
  _EmailVerifyPageState createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  TextEditingController? ftController;
  TextEditingController? scController;
  TextEditingController? tdController;
  TextEditingController? frController;
  TextEditingController? fvController;
  TextEditingController? textEditingController;

  bool isButtonActive = false;
  bool isValid = true;
  String? code;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String attemptId = '';
  String emailAddress = '';
  bool? verifyEmail;
  String name = '';
  String surname = '';
  String password = '';
  String phoneNumber = '';
  bool? canLogin;
  final String baseUrl = 'http://api.test.apti.us';
  RegisterService? registerService;

  void readAttemptId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('attemptId') == null) {
      setState(() => attemptId = '');
    } else {
      setState(() => attemptId = prefs.getString('attemptId')!);
    }
  }

  readVerify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('verify-email') == null) {
      setState(() => verifyEmail = false);
    } else {
      setState(() => verifyEmail = prefs.getBool('verify-email')!);
    }
  }

  readCanLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('can-login') == null) {
      setState(() => canLogin = false);
    } else {
      setState(() => canLogin = prefs.getBool('can-login')!);
    }
  }

  void readOtherData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("name") != null) {
      setState(() => name = prefs.getString("name")!);
    }
    if (prefs.getString("surname") != null) {
      setState(() => surname = prefs.getString("surname")!);
    }
    if (prefs.getString("emailAddress") != null) {
      setState(() => emailAddress = prefs.getString("emailAddress")!);
    }
    if (prefs.getString("password") != null) {
      setState(() => password = prefs.getString("password")!);
    }
    if (prefs.getString("phoneNumber") != null) {
      setState(() => phoneNumber = prefs.getString("phoneNumber")!);
    }
  }

  @override
  void initState() {
    super.initState();
    ftController = TextEditingController();
    scController = TextEditingController();
    tdController = TextEditingController();
    frController = TextEditingController();
    fvController = TextEditingController();
    textEditingController = TextEditingController();
    textEditingController!.addListener(() {
      final isButtonActive = textEditingController!.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    readAttemptId();
    readOtherData();
    registerService = RegisterService(Dio(BaseOptions(baseUrl: baseUrl)));
  }

  @override
  void dispose() {
    textEditingController!.dispose();
    ftController!.dispose();
    scController!.dispose();
    tdController!.dispose();
    frController!.dispose();
    fvController!.dispose();
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_label
    resizeToAvoidBottomInset:
    false;
    ScreenUtil.init(context, designSize: const Size(305, 785));

    return BlocProvider(
      create: (BuildContext context) => VerifyEmailCubit(
        formKey,
        service: RegisterService(Dio(BaseOptions(baseUrl: baseUrl))),
      ),
      child: BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
        listener: (context, state) {
          if (state is VerifyComplete) {
            Navigator.of(context).pushNamed(LoginPage.routeName);
          }
        },
        builder: (context, state) {
          return _buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context, VerifyEmailState state) {
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
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Kayıt Işlemini Tamamlayın',
                style: TextStyle(color: AppColors.aptidarkblue5, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(50)),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(17),
                right: ScreenUtil().setWidth(16),
              ),
              child: Container(
                width: ScreenUtil().setWidth(380),
                height: ScreenUtil().setHeight(290),
                // width: 380,
                //height: 290,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: _buildContent(context),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(380),
              height: ScreenUtil().setHeight(70),
              // width: 380,
              //height: 70,
              margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
                left: ScreenUtil().setWidth(18),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(13)),
                child: _buildButton(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              //right: 120
              // right: ScreenUtil().setWidth(62)
              ScreenUtil().setWidth(10),
              ScreenUtil().setHeight(0),
              ScreenUtil().setWidth(80),
              ScreenUtil().setHeight(0)),
          child: Text(
            LocaleKeys.app_otp_otp_card_title_text.tr(),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(16),
              ScreenUtil().setHeight(0),
              ScreenUtil().setWidth(10),
              ScreenUtil().setHeight(0)),
          child: Text(
            LocaleKeys.app_otp_otp_card_desc_text.tr(),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(11),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(9),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(16),
                  ScreenUtil().setHeight(0),
                  ScreenUtil().setWidth(10),
                  ScreenUtil().setHeight(0)),
              child: Text(
                '($emailAddress)',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
            TextButton(
                child: Text(
                  LocaleKeys.app_otp_otp_card_change_email_text_button.tr(),
                  style: TextStyle(
                      color: AppColors.aptiblueprimary,
                      fontSize: ScreenUtil().setSp(11),
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  // print('Pressed');
                }),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(14),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _buildFirstCell(context),
            _buildSecondCell(context),
            _buildThirdCell(context),
            _buildFourCell(context),
            _buildFifeCell(context),
            _buildLastCell(context),
          ]),
        ),
        if (!isValid)
          Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                LocaleKeys.app_otp_otp_card_valid_text.tr(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        !isValid
            ? SizedBox(
                height: ScreenUtil().setHeight(30),
              )
            : SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
        Text(
          LocaleKeys.app_otp_otp_card_resend_code_text_button.tr(),
          style: const TextStyle(
              color: AppColors.aptiblueprimary,
              fontSize: 16.0,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildLastCell(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: ScreenUtil().setHeight(12),
      ),

      width: ScreenUtil().setWidth(35),
      height: ScreenUtil().setHeight(46),
      //width: 50,
      // height: 49,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(width: 1, color: isValid ? Colors.black12 : Colors.red),
        color: Colors.black12,
      ),
      child: TextField(
        controller: textEditingController,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }

  Widget _buildFifeCell(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: ScreenUtil().setHeight(9),
      ),
      width: ScreenUtil().setHeight(46),
      height: ScreenUtil().setHeight(46),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(width: 1, color: isValid ? Colors.black12 : Colors.red),
        color: Colors.black12,
      ),
      child: TextField(
        controller: fvController,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }

  Widget _buildFourCell(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: ScreenUtil().setHeight(9),
      ),
      width: ScreenUtil().setHeight(46),
      height: ScreenUtil().setHeight(46),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: isValid ? Colors.black12 : Colors.red),
          color: Colors.black12),
      child: TextField(
        controller: frController,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }

  Widget _buildThirdCell(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: ScreenUtil().setHeight(9),
      ),
      width: ScreenUtil().setHeight(46),
      height: ScreenUtil().setHeight(46),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: isValid ? Colors.black12 : Colors.red),
          color: Colors.black12),
      child: TextField(
        controller: tdController,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }

  Widget _buildSecondCell(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: ScreenUtil().setHeight(9),
      ),
      width: ScreenUtil().setHeight(46),
      height: ScreenUtil().setHeight(46),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: isValid ? Colors.black12 : Colors.red),
          color: Colors.black12),
      child: TextField(
        controller: scController,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }

  Widget _buildFirstCell(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: ScreenUtil().setHeight(5),
      ),
      width: ScreenUtil().setHeight(46),
      height: ScreenUtil().setHeight(46),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(width: 1, color: isValid ? Colors.black12 : Colors.red),
        color: Colors.black12,
      ),
      child: TextField(
        controller: ftController,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            Visibility(
                visible: isLoading, child: const CircularProgressIndicator()),
            SizedBox(
              width: 380,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.aptiblueprimary,
                  onSurface: AppColors.aptilightgray4,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
                onPressed: isButtonActive
                    ? () async {
                        setState(() {
                          code = ftController!.text +
                              scController!.text +
                              tdController!.text +
                              frController!.text +
                              fvController!.text +
                              textEditingController!.text;
                          isLoading = true;
                        });
                        await context
                            .read<VerifyEmailCubit>()
                            .service
                            .verifyEmail(
                              attemptId: attemptId,
                              code: code!,
                            )
                            .then((value) async {
                          await readVerify();
                          verifyEmail!
                              ? (await registerService!
                                  .userRegister(
                                      name: name,
                                      surname: surname,
                                      emailAddress: emailAddress,
                                      password: password,
                                      phoneNumber: phoneNumber)
                                  .then((value) async {
                                  await readCanLogin();
                                  if (canLogin == true) {
                                    Navigator.of(context)
                                        .pushNamed(LoginPage.routeName);
                                  } else {
                                    setState(() {
                                      isValid = false;
                                      isLoading = false;
                                    });
                                  }
                                }))
                              : (setState(() {
                                  isValid = false;
                                  isLoading = false;
                                }));
                        });
                        setState(() {
                          isLoading = false;
                        });
                      }
                    : null,
                child: const Text(
                  'Doğrula',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


// extension extEmailVerifyPage on String {
//   bool get isValidEmail {
//     final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//     return emailRegExp.hasMatch(this);
//   }

//   bool get isValidName {
//     final nameRegExp =
//         RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
//     return nameRegExp.hasMatch(this);
//   }

//   bool get isValidSurname {
//     final nameRegExp =
//         RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
//     return nameRegExp.hasMatch(this);
//   }

//   bool get isValidPassword {
//     final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
//     return passwordRegExp.hasMatch(this);
//   }

//   bool get isNotNull {
//     return this != null;
//   }

//   bool get isValidPhone {
//     final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
//     return phoneRegExp.hasMatch(this);
//   }
// }


// await context
//                                 .read<RegisterCubit>()
//                                 .service
//                                 .userRegister(
//                                     name: name,
//                                     surname: surname,
//                                     emailAddress: emailAddress,
//                                     password: password,
//                                     phoneNumber: phoneNumber)
//                                 .then((value) async {
//                                 await readCanLogin();
//                                 debugPrint("${canLogin} from userRegister");
//                                 if (canLogin == true)
//                                   Navigator.of(context)
//                                       .pushNamed(LoginPage.routeName);
//                               })
