import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/i18n/locale/en_us.dart';
import 'package:example/i18n/locale/zh_cn.dart';

enum I18nLocale { zh_CN, en_US }

class I18nTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'zh_CN': zhCN, 'en_US': enUS};

  static Locale? getLocale() {
    return Get.locale;
  }

  static void updateLocale(I18nLocale locale) {
    var localeSplit = locale.toString().split('_');
    Get.updateLocale(Locale(localeSplit[0].split('.')[1], localeSplit[1]));
  }
}
