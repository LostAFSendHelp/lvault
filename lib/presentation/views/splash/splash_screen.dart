import 'package:flutter/cupertino.dart';
import 'package:lvault/presentation/views/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController _controller;

  const SplashScreen({
    super.key,
    required SplashController controller,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text(
          "LVault",
          style: TextStyle(
            color: CupertinoColors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
