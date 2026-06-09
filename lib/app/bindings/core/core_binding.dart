import 'package:get/get.dart';
import 'package:pokemon_app/core/core.dart'
    show ConnectivityService, DioClient, FirebaseService, HiveService;

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<DioClient>(
        DioClient(),
        permanent: true,
      )
      ..put<ConnectivityService>(
        ConnectivityService(),
        permanent: true,
      )
      ..put<FirebaseService>(
        FirebaseService(),
        permanent: true,
      )
      ..put<HiveService>(
        HiveService(),
        permanent: true,
      );
  }
}
