import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/handlers/notification_handler.dart';
import 'package:flutter_project_template/logic/services/theme_service.dart';
import 'package:flutter_project_template/view/features/about/about_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_template/core/app/global.dart';
import 'package:flutter_project_template/core/i18n/translations.g.dart';
import 'package:flutter_project_template/view/app/home_page.dart';
import 'package:flutter_project_template/view/app/auth_page.dart';
import 'package:flutter_project_template/view/app/start_page.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      manager: context.get<ThemeService>(),
      builder: (ThemeMode themeMode) {
        return NotificationHandler(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp(
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              debugShowCheckedModeBanner: false,
              theme: App.themes.light,
              darkTheme: App.themes.dark,
              themeMode: themeMode,
              initialRoute: Routes.index,
              navigatorKey: App.navigatorKey,
              routes: {
                Routes.index: (context) => const StartPage(),
                Routes.about: (context) => const AboutPage(),
                Routes.auth: (context) => const AuthPage(),
                Routes.home: (context) => const HomePage(),
              },
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
