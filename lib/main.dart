import 'package:Apti/view/onboarding_page.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/navigation/page_route.dart';

Future<void> main() async {
  await _init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'US')],
      path: 'asset/lang',
      child: MyApp(),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: OnboardingScreen.routeName,
      onGenerateRoute: MyPageRoute.generateRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      //  onGenerateRoute: NavigationRoute.instance.generateRoute,
      //navigatorKey: NavigationService.instance.navigatorKey,
      //   navigatorObservers: AnalytcisManager.instance.observer,
    );
  }
}
