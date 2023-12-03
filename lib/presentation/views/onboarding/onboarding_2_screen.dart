import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lvault/presentation/views/onboarding/onboarding_2_controller.dart';

class Onboarding2Screen extends StatelessWidget {
  final Onboarding2Controller _controller;

  const Onboarding2Screen({
    super.key,
    required Onboarding2Controller controller,
  }) : _controller = controller;

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
        return const Text(
          "Make sure to enter a decimal value",
          textAlign: TextAlign.center,
        );
      }
    });

    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            previousPageTitle: "Back",
            onPressed: () => _controller.back(),
          ).paddingOnly(left: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Now give your pocket an amount to start the month with",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                keyboardType: TextInputType.number,
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
        ],
      ),
    );
  }
}
