import 'package:Apti/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../core/colors/app_colors.dart';

class ForgotPasswordInfoPage extends StatefulWidget {
  //EasyLocalization

  static const routeName = '/password_forget_info';

  const ForgotPasswordInfoPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordInfoPageState createState() => _ForgotPasswordInfoPageState();
}

class _ForgotPasswordInfoPageState extends State<ForgotPasswordInfoPage> {
  final bool _customTileExpanded = false;
  static const double radius = 15;

  UniqueKey? keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: const BorderSide(color: AppColors.aptilightgray2, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => isExpanded ? shrinkTile() : expandTile(),
                    child: _buildEpostaText(),
                  ),
                  buildText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // const ExpansionTile(
    //   // childrenPadding:
    //   //     const EdgeInsets.all(10).copyWith(top: 0),
    //   //  tilePadding: EdgeInsetsGeometry.lerp(, b, t),
    //   title: Text('E-posta ulaşmadı mı?'),
    //   // subtitle: Text('Trailing expansion arrow icon'),
    //   children: <Widget>[
    //     ListTile(
    //         contentPadding: EdgeInsets.only(top: 10),
    //         title: Text(
    //           ' * Gönderdiğimiz e-posta "spam" klasörüne düşmüş olabilir.',
    //           textAlign: TextAlign.left,
    //         )),
    //     ListTile(
    //         title: Text(
    //       'E-posta adresinizi doğru yazdığınızdan ve spam klasörünüzde ilgili e-postanın olmadığından eminseniz, şifre değişiklik e-postasının tekrar gönderilmesi için tıklayın.',
    //       textAlign: TextAlign.left,
    //     )),
    //   ],
    // ),

    //  _buildEpostaText(),
  }

  Widget _buildEpostaText() {
    return const Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 20),
      child: Text(
        'Şifre Değişikliği Bağlantısı E-posta Adresinize Gönderildi!',
        textAlign: TextAlign.left,
        maxLines: 5,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildText(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: keyTile,
          initiallyExpanded: isExpanded,
          childrenPadding: const EdgeInsets.all(15).copyWith(top: 0),
          title: const Text(
            'E-posta ulaşmadı mı?',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.aptiblueprimary),
          ),
          children: const [
            Text(
              '* Gönderdiğimiz e-posta "spam" klasörüne düşmüş olabilir.',
              style: TextStyle(fontSize: 18, height: 1.4),
            ),
            Text(
              '* E-posta adresinizi doğru yazdığınızdan ve spam klasörünüzde ilgili e-postanın olmadığından eminseniz, şifre değişiklik e-postasının tekrar gönderilmesi için tıklayın.',
              style: TextStyle(fontSize: 18, height: 1.4),
            ),
          ],
          // onExpansionChanged: (isExpanded) => Utils.showSnackBar(
          //   context,
          //   text: isExpanded ? 'Expand Tile' : 'Shrink Tile',
          //   color: isExpanded ? Colors.green : Colors.red,
          // ),
        ),
      );
}

Widget _buildContent(BuildContext context) {
  return Column(
    children: const [
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: EdgeInsets.only(right: 100),
        child: Text(
          'Şifre Değişikliği Bağlantısı E-posta Adresinize Gönderildi!',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(
        height: 17,
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Şifrenizi yenilemek için e-posta adresinize bir link gelecektir. Gelen linke tıklayıp yeni şifrenizi belirleyebilirsiniz.',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );
}






// extension extForgotPasswordInfo on String {
 
//   bool get isValidPassword {
//     final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
//     return passwordRegExp.hasMatch(this);
//   }

//   bool get isNotNull {
//     return this != null;
//   }

  
// }

