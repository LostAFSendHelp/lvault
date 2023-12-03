import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lvault/domain/usecases/pocket/pocket_uc_provider.dart';

class Onboarding2Controller {
  final String pocketName;
  final PocketUsecaseProvider _pocketUsecaseProvider;
  final TextEditingController textEditingController = TextEditingController();

  Onboarding2Controller({
    required this.pocketName,
    required PocketUsecaseProvider pocketUsecaseProvider,
  }) : _pocketUsecaseProvider = pocketUsecaseProvider;

  final Rx<String?> error = Rxn(null);

  String get pocketAmount => textEditingController.text;

  void back() {
    Get.back();
  }

  void submit() async {
    final amount = double.tryParse(pocketAmount);

    if (amount == null) {
      error.value = "Invalid value";
      return;
    }

    final pocket = _pocketUsecaseProvider.createPocket().call(name: pocketName);
    // do something with pocket: create a snapshot
  }
}
