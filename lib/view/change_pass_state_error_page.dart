import 'package:apti_mobile/localization/locale_keys.g.dart';
import 'package:apti_mobile/view/widgets/login_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassStatePage extends StatefulWidget {
  static const routeName = '/change_page_state_page';
  const ChangePassStatePage({Key? key}) : super(key: key);

  @override
  _ChangePassStatePageState createState() => _ChangePassStatePageState();
}

class _ChangePassStatePageState extends State<ChangePassStatePage> {
  // ScreenUtil().setWidth(17),
  //ScreenUtil().setHeight(16),

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(305, 785));
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
              padding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(50),
                  left: ScreenUtil().setWidth(16),
                  right: ScreenUtil().setWidth(16)),
              child: SizedBox(
                width: ScreenUtil().setWidth(340),
                height: ScreenUtil().setHeight(260),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(14.0),
                      color: AppColors.aptilightgray0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setHeight(10),
                            ScreenUtil().setWidth(20),
                            ScreenUtil().setHeight(10),
                            ScreenUtil().setHeight(10)),
                        child: SizedBox(
                          width: ScreenUtil().setWidth(96),
                          height: ScreenUtil().setHeight(96),
                          child: Image.asset(
                              'asset/image/pass_error_state_icon.png'),
                        ),
                      ),
                      SizedBox(
                        // width: ScreenUtil().setWidth(10),
                        height: ScreenUtil().setHeight(20),
                      ),
                      Text(
                        LocaleKeys
                            .change_password_time_expire_change_password_time_expire_title
                            .tr(),
                        style: const TextStyle(
                            color: AppColors.aptierrorred4,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(16)),
                      Text(LocaleKeys
                          .change_password_time_expire_change_password_time_expire_subtext
                          .tr()),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   width: 365,
            //   height: 50,
            //   margin: const EdgeInsets.only(
            //     top: 20,
            //     left: 24,
            //   ),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(14.0),
            //   ),
            //   child: Column(
            //     children: [
            //       Image.asset('asset/image/pass_error_state_icon.png'),
            //       const Text('data'),
            //       const SizedBox(height: 5),
            //       const Text('data'),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
