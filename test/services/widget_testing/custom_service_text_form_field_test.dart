import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/services/view/widgets/custom_service_text_form_field.dart';

void main() {
  Widget makeTestableWidget({
    required String hintText,
    required String? Function(String?) validator,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
    required IconData icon,
    String? initailValue,
    int? maxLines = 1,
    TextInputType? keyboardType,
    GlobalKey<FormState>? formKey,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: formKey,
          child: CustomServiceTextFormField(
            hintText: hintText,
            validator: validator,
            onSaved: onSaved,
            onChanged: onChanged,
            icon: icon,
            initailValue: initailValue,
            maxLines: maxLines,
            keyboardType: keyboardType,
          ),
        ),
      ),
    );
  }

  group('CustomServiceTextFormField', () {
    testWidgets('renders hint text and icon', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          hintText: 'Enter name',
          validator: (_) => null,
          icon: Icons.person,
        ),
      );

      expect(find.text('Enter name'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('displays initial value', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          hintText: 'Enter name',
          validator: (_) => null,
          icon: Icons.person,
          initailValue: 'John Doe',
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        makeTestableWidget(
          hintText: 'Enter name',
          validator: (_) => null,
          icon: Icons.person,
          onChanged: (value) => changedValue = value,
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Hello');
      expect(changedValue, 'Hello');
    });

    testWidgets('calls onSaved when form is saved', (tester) async {
      String? savedValue;
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        makeTestableWidget(
          formKey: formKey,
          hintText: 'Enter name',
          validator: (_) => null,
          icon: Icons.person,
          onSaved: (value) => savedValue = value,
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Saved Text');
      formKey.currentState!.save();

      expect(savedValue, 'Saved Text');
    });

    testWidgets('shows validation error when validator fails', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        makeTestableWidget(
          formKey: formKey,
          hintText: 'Enter name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          icon: Icons.person,
        ),
      );

      // Trigger validation with empty field
      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('shows no validation error when input is valid', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        makeTestableWidget(
          formKey: formKey,
          hintText: 'Enter name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          icon: Icons.person,
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Valid text');
      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('This field is required'), findsNothing);
    });

    testWidgets('respects keyboardType', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          hintText: 'Enter phone',
          validator: (_) => null,
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
        ),
      );

      // Access underlying EditableText to check keyboardType
      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      expect(editableText.keyboardType, TextInputType.phone);
    });

    testWidgets('respects maxLines', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          hintText: 'Enter description',
          validator: (_) => null,
          icon: Icons.description,
          maxLines: 3,
        ),
      );

      final editableText = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      expect(editableText.maxLines, 3);
    });
  });
}
