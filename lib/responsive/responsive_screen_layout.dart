import 'package:flutter/widgets.dart';

class ResponsiveScreenLayout extends StatelessWidget {
  final Widget mobileScreen;
  final Widget webScreen;

  const ResponsiveScreenLayout({
    super.key,
    required this.mobileScreen,
    required this.webScreen,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return webScreen;
        }
        return mobileScreen;
      },
    );
  }
}
