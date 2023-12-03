import 'package:get/get.dart';
import 'package:lvault/domain/usecases/pocket/pocket_uc_provider.dart';
import 'package:lvault/presentation/views/homepage/homepage_controller.dart';
import 'package:lvault/presentation/views/homepage/homepage_screen.dart';
import 'package:lvault/presentation/views/onboarding/onboarding_controller.dart';
import 'package:lvault/presentation/views/onboarding/onboarding_screen.dart';

class SplashController {
  final PocketUsecaseProvider _pocketUsecaseProvider;

  SplashController({required PocketUsecaseProvider pocketUsecaseProvider})
      : _pocketUsecaseProvider = pocketUsecaseProvider {
    _checkToNavigate();
  }

  final count = 0.obs;

  void increment() {
    count.value += 1;
  }

  Future<void> _checkToNavigate() async {
    // fake loading
    await Future.delayed(const Duration(seconds: 2));

    // get all pockets
    final pockets = await _pocketUsecaseProvider.getAllPockets().call();

    if (pockets.isEmpty) {
      Get.off(
        () => OnboardingScreen(
          controller: OnboardingController(
            pocketUsecaseProvider: _pocketUsecaseProvider,
          ),
        ),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 500),
      );
    } else {
      Get.off(
        () => HomepageScreen(controller: HomepageController()),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 500),
      );
    }
  }
}
