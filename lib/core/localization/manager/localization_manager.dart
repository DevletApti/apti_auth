import 'package:flutter/material.dart';

import 'interface_localization_manager.dart';

enum LocalizationEnum {
  TURKCE,
  ENGLISH,
}

extension LocalizationExtension on LocalizationEnum {
  Locale? get translate {
    switch (this) {
      case LocalizationEnum.TURKCE:
        return LocalizationManager.instance.trTRLocale;
      case LocalizationEnum.ENGLISH:
        return LocalizationManager.instance.enUSLocale;
      default:
        return LocalizationManager.instance.trTRLocale;
    }
  }
}

class LocalizationManager implements ILocalizationManager {
  static LocalizationManager? _instance;
  static LocalizationManager get instance {
    _instance ??= LocalizationManager._init();
    return _instance!;
  }

  LocalizationManager._init();

  @override
  String? localePath = 'asset/lang';

  final enUSLocale = const Locale('en', 'US');
  final trTRLocale = const Locale('tr', 'TR');

  @override
  List<Locale> get supportedLocales => [enUSLocale, trTRLocale];

  @override
  LocalizationEnum currentLocale = LocalizationEnum.TURKCE;
}
