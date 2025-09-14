import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/i18n/locale/en_us.dart';
import 'package:example/i18n/locale/zh_cn.dart';

enum I18nLocale { zhCN, enUS }

class I18nTranslations extends Translations {
  //这里的key必须是 languageCode_countryCode
  @override
  Map<String, Map<String, String>> get keys => {'zh_CN': zhCN, 'en_US': enUS};

  static const _localeMap = {
    I18nLocale.zhCN: Locale('zh', 'CN'),
    I18nLocale.enUS: Locale('en', 'US'),
  };

  static Locale? getLocale() {
    return Get.locale;
  }

  static void updateLocale(I18nLocale locale) {
    Get.updateLocale(_localeMap[locale]!);
  }
}
