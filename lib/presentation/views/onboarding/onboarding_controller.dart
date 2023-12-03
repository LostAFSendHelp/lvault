import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lvault/domain/usecases/pocket/pocket_uc_provider.dart';
import 'package:lvault/presentation/views/onboarding/onboarding_2_controller.dart';
import 'package:lvault/presentation/views/onboarding/onboarding_2_screen.dart';

class OnboardingController {
  final PocketUsecaseProvider _pocketUsecaseProvider;

  OnboardingController({
    required PocketUsecaseProvider pocketUsecaseProvider,
  }) : _pocketUsecaseProvider = pocketUsecaseProvider;

  final TextEditingController textEditingController = TextEditingController();

  String get pocketName => textEditingController.text;

  final Rx<String?> error = Rxn(null);

  void submit() {
    if (pocketName.trim().isEmpty) {
      error.value = "Pocket name must not be empty";
      return;
    }

    error.value = null;
    FocusManager.instance.primaryFocus?.unfocus();

    Get.to(
      () => Onboarding2Screen(
        controller: Onboarding2Controller(
          pocketName: pocketName,
          pocketUsecaseProvider: _pocketUsecaseProvider,
        ),
      ),
    );
  }
}
