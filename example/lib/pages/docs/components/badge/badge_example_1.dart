import 'package:shadcn_flutter/shadcn_flutter.dart';

class BadgeExample1 extends StatelessWidget {
  const BadgeExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      padding: Button.badgePadding,
      child: Text('Primary'),
    );
  }
}
