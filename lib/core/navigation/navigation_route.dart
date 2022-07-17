// import 'package:flutter/material.dart';

// import '../../view/login_page.dart';
// import '../../view/register_page.dart';

// import '../../view/widgets/not_found_navigation_widget.dart';
// import 'constants/navigation_constants.dart';


// class NavigationRoute {
//   static final NavigationRoute _instance = NavigationRoute._init();
//   static NavigationRoute get instance => _instance;

//   NavigationRoute._init();

//   Route<dynamic> generateRoute(RouteSettings args) {
//     switch (args.name) {
//       case NavigationConstants.DEFAULT:
//         return normalNavigate( LoginPage(), NavigationConstants.LOGIN_VIEW);

//       // ignore: no_duplicate_case_values
//       case NavigationConstants.DEFAULT:
//         return normalNavigate(const RegisterPage(), NavigationConstants.REGISTER_VIEW);

   

//       default:
//         return MaterialPageRoute(
//           builder: (context) => NotFoundNavigationWidget(),
//         );
//     }
//   }

//   MaterialPageRoute normalNavigate(Widget widget, String pageName) {
//     return MaterialPageRoute(
//         builder: (context) => widget,
//         settings: RouteSettings(name: pageName));
//   }
//}