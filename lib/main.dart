import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:teste_app/src/constants/colors.dart';
import 'package:teste_app/src/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        title: 'Tasker',
        defaultTransition: Transition.fade,
        transitionDuration: const Duration(seconds: 1),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: CustomColors.customAccentColor,
          scaffoldBackgroundColor: CustomColors.customPrimaryColor,
        ),
        initialRoute: PagesRoutes.splash,
        getPages: AppPages.pages,
      ),
    );
  }
}
