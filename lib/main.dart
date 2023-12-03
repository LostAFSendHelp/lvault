import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lvault/data/datasources/local/database_service.dart';
import 'package:lvault/domain/usecases/pocket/pocket_uc_provider.dart';
import 'package:lvault/presentation/views/splash/splash_controller.dart';
import 'package:lvault/presentation/views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseService dbService = DatabaseService();
  await dbService.initialize();
  Get.put(dbService);
  runApp(const LVaultApp());
}

class LVaultApp extends StatelessWidget {
  const LVaultApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      theme: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(primaryColor: Colors.white)),
      home: SplashScreen(
        controller: SplashController(
          pocketUsecaseProvider: PocketUsecaseProvider.instance,
        ),
      ),
    );
  }
}
