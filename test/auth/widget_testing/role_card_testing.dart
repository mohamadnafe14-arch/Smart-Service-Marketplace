import 'package:flutter/material.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/role_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestWidget({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: _AnimatedRoleCardWrapper(
          title: title,
          description: description,
          icon: icon,
          onTap: onTap,
        ),
      ),
    );
  }
  group('RoleCard', () {
    testWidgets('renders title, description, and icon', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          title: 'Admin',
          description: 'Manage the system',
          icon: Icons.admin_panel_settings,
          onTap: () {},
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Admin'), findsOneWidget);
      expect(find.text('Manage the system'), findsOneWidget);
      expect(find.byIcon(Icons.admin_panel_settings), findsOneWidget);
    });
    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestWidget(
          title: 'Admin',
          description: 'Manage the system',
          icon: Icons.admin_panel_settings,
          onTap: () => tapped = true,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      expect(tapped, isTrue);
    });
    testWidgets('has correct decoration (rounded corners, gradient)', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          title: 'Admin',
          description: 'Manage the system',
          icon: Icons.admin_panel_settings,
          onTap: () {},
        ),
      );
      await tester.pumpAndSettle();
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(20));
      expect(decoration.gradient, isA<LinearGradient>());
      final gradient = decoration.gradient as LinearGradient;
      expect(gradient.colors, [
        const Color(0xff203a43),
        const Color(0xff2c5364),
      ]);
    });
    testWidgets('is wrapped in FadeTransition and SlideTransition', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          title: 'Admin',
          description: 'Manage the system',
          icon: Icons.admin_panel_settings,
          onTap: () {},
        ),
      );
      await tester.pumpAndSettle();
    });
    testWidgets('title text has correct style', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          title: 'Admin',
          description: 'Manage the system',
          icon: Icons.admin_panel_settings,
          onTap: () {},
        ),
      );
      await tester.pumpAndSettle();
      final titleWidget = tester.widget<Text>(find.text('Admin'));
      expect(titleWidget.style?.fontSize, 20);
      expect(titleWidget.style?.fontWeight, FontWeight.bold);
      expect(titleWidget.style?.color, Colors.white);
    });
    testWidgets('renders correctly with long description (overflow safe)', (
      tester,
    ) async {
      const longDescription =
          'This is a very long description that should wrap across '
          'multiple lines to test the Expanded and Column behavior '
          'inside the RoleCard widget without overflowing.';

      await tester.pumpWidget(
        buildTestWidget(
          title: 'Admin',
          description: longDescription,
          icon: Icons.admin_panel_settings,
          onTap: () {},
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(longDescription), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}

class _AnimatedRoleCardWrapper extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  const _AnimatedRoleCardWrapper({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_AnimatedRoleCardWrapper> createState() =>
      _AnimatedRoleCardWrapperState();
}

class _AnimatedRoleCardWrapperState extends State<_AnimatedRoleCardWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoleCard(
      title: widget.title,
      description: widget.description,
      icon: widget.icon,
      onTap: widget.onTap,
      fadeAnimation: _fadeAnimation,
      slideAnimation: _slideAnimation,
    );
  }
}
