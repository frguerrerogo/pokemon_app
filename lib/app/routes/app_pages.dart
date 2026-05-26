// app/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppRoutes, LoginBinding, RegisterBinding;
import 'package:pokemon_app/features/auth/presentation/presentation.dart'
    show LoginScreen, RegisterScreen;
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart' show HomeScreen;

class AppPages {
  static const String initial = AppRoutes.login;

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      //binding: HomeBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.detail,
    //   page: () => const DetailScreen(),
    // ),
  ];
}
