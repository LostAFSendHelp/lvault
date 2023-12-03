import 'package:flutter/cupertino.dart';
import 'package:lvault/presentation/views/homepage/homepage_controller.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key, required HomepageController controller,}): _controller = controller;

  final HomepageController _controller;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(child: Text('LVault')),
    );
  }
}
