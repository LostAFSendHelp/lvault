import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lvault/presentation/views/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, required OnboardingController controller})
      : _controller = controller;

  final OnboardingController _controller;

  @override
  Widget build(BuildContext context) {
    final infoText = Obx(() {
      final error = _controller.error.value;
      if (error != null) {
        return Text(
          error,
          style: const TextStyle(color: CupertinoColors.systemRed),
        );
      } else {
        return const Text("Enter your pocket's name");
      }
    });

    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Looks like you're just getting started. Let's begin by creating a pocket for your vault",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CupertinoTextField(
            textAlign: TextAlign.center,
            controller: _controller.textEditingController,
          ),
          const SizedBox(height: 8),
          infoText,
          const SizedBox(height: 16),
          CupertinoButton.filled(
            onPressed: () => _controller.submit(),
            child: const Text("Confirm"),
          )
        ],
      ).paddingAll(16),
    );
  }
}
