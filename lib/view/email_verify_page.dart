import 'package:Apti/cubit/verify_email_cubit.dart';
import 'package:Apti/cubit/verify_email_state.dart';
import 'package:Apti/localization/locale_keys.g.dart';
import 'package:Apti/view/login_page.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  readOtherData() async {
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
  // getString(String key) async {
  //   SharedPreferences prefs = await _prefs;
  //   return prefs.getString(key).toString();
  // }

  // getBool(String key) async {
  //   SharedPreferences prefs = await _prefs;
  //   return prefs.getBool(key);
  // }

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
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(color: AppColors.aptidarkblue2, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 18,
            ),
            child: Container(
              width: 343,
              height: 270,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: _buildContent(context),
            ),
          ),
          Container(
            width: 380,
            height: 70,
            margin: const EdgeInsets.only(
              top: 20,
              left: 18,
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

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          LocaleKeys.app_otp_otp_card_title_text.tr(),
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          LocaleKeys.app_otp_otp_card_desc_text.tr(),
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              '($emailAddress)',
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
            ),
            Text(
              LocaleKeys.app_otp_otp_card_change_email_text_button.tr()

              // ' E-posta adresini degishtir'
              ,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildFirstCell(context),
          _buildSecondCell(context),
          _buildThirdCell(context),
          _buildFourCell(context),
          _buildFifeCell(context),
          _buildLastCell(context),
        ]),
        if (!isValid)
          Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              Text(
                'Doğrulama kodu hatalı. Lütfen tekrar deneyiniz.',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        !isValid
            ? const SizedBox(
                height: 38,
              )
            : const SizedBox(
                height: 35,
              ),
        const Text(
          'Doğurlama kodunu yaniden gönder',
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 19.0,
          ),
        ),
      ],
    );
  }

  Widget _buildLastCell(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 9,
      ),
      width: 50,
      height: 49,
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
      margin: const EdgeInsets.only(
        right: 9,
      ),
      width: 50,
      height: 49,
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
      margin: const EdgeInsets.only(
        right: 9,
      ),
      width: 50,
      height: 49,
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
      margin: const EdgeInsets.only(
        right: 9,
      ),
      width: 50,
      height: 49,
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
      margin: const EdgeInsets.only(
        right: 9,
      ),
      width: 50,
      height: 49,
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
      margin: const EdgeInsets.only(
        right: 9,
      ),
      width: 50,
      height: 49,
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.aptiblueprimary,
                onSurface: Colors.blueAccent,
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
                      debugPrint(
                          "$attemptId and $code => attemptId from Verify Page");
                      await context
                          .read<VerifyEmailCubit>()
                          .service
                          .verifyEmail(
                            attemptId: attemptId,
                            code: code!,
                          )
                          .then((value) async {
                        await readVerify();
                        await readOtherData();
                        debugPrint(
                            "verifyEmail -> $verifyEmail   AttemptId -> $attemptId ");
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
                                debugPrint("canLogin -> $canLogin from userRegister");
                                if (canLogin == true) {
                                  Navigator.of(context)
                                      .pushNamed(LoginPage.routeName);
                                } else {
                                  setState(() => isValid = false);
                                }
                              }))
                            : (setState(() => isValid = false));
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
          ],
        );
      },
    );
  }
}

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
