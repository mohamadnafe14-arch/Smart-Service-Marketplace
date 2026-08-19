import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/auth/view/widgets/custom_text_form_field.dart';

void main() {
  Widget createWidgetUnderTest({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
    GlobalKey<FormState>? formKey,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: CustomTextFormField(
            hintText: hintText,
            icon: icon,
            isPassword: isPassword,
            validator: validator ?? (value) => null,
            onSaved: onSaved,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  group('CustomTextFormField', () {
    testWidgets('renders hint text and icon correctly', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(hintText: 'Enter your email', icon: Icons.email),
      );
      expect(find.text('Enter your email'), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
    testWidgets('calls onChanged when text is entered', (tester) async {
      String? changedValue;
      await tester.pumpWidget(
        createWidgetUnderTest(
          hintText: 'Name',
          icon: Icons.person,
          onChanged: (value) => changedValue = value,
        ),
      );
      await tester.enterText(find.byType(TextFormField), 'John Doe');
      expect(changedValue, 'John Doe');
    });
    testWidgets('calls onSaved with correct value on form save', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      String? savedValue;
      await tester.pumpWidget(
        createWidgetUnderTest(
          hintText: 'Email',
          icon: Icons.email,
          formKey: formKey,
          onSaved: (value) => savedValue = value,
        ),
      );
      await tester.enterText(find.byType(TextFormField), 'test@example.com');
      formKey.currentState!.save();
      expect(savedValue, 'test@example.com');
    });
    testWidgets('shows validation error when validator returns error message', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        createWidgetUnderTest(
          hintText: 'Email',
          icon: Icons.email,
          formKey: formKey,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      );
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('This field is required'), findsOneWidget);
    });
    testWidgets('does not show validation error when input is valid', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        createWidgetUnderTest(
          hintText: 'Email',
          icon: Icons.email,
          formKey: formKey,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      );
      await tester.enterText(find.byType(TextFormField), 'valid@example.com');
      formKey.currentState!.validate();
      await tester.pump();
      expect(find.text('This field is required'), findsNothing);
    });
  });
}
