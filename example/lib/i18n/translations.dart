import 'package:flutter/material.dart';
import 'package:example/i18n/locale/en_us.dart';
import 'package:example/i18n/locale/zh_cn.dart';
import 'package:flutter_better_ui/better_ui.dart';

enum I18nLocale { zhCN, enUS }

class I18nTranslations {
  //这里的key必须是 languageCode_countryCode
  Map<String, Map<String, String>> get keys => {'zh_CN': zhCN, 'en_US': enUS};

  static const _localeMap = {
    I18nLocale.zhCN: Locale('zh', 'CN'),
    I18nLocale.enUS: Locale('en', 'US'),
  };

  static Locale? getLocale() {
    return BetterUi.currentLocale;
  }

  static void updateLocale(I18nLocale locale) {
    BetterUi.updateLocale(_localeMap[locale]!);
  }
}
