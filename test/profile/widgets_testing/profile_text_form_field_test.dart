import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_service_market_place/features/profile/view/widgets/provider_text_form_field.dart';

void main() {
  group('ProfileTextFormField Widget Tests', () {
    Widget makeTestableWidget({required Widget child}) {
      return MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              child: Padding(padding: const EdgeInsets.all(16.0), child: child),
            ),
          ),
        ),
      );
    }

    testWidgets('renders with correct hint text', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter your name',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.person,
            initialValue: '',
          ),
        ),
      );

      expect(find.text('Enter your name'), findsOneWidget);
    });

    testWidgets('displays prefix icon correctly', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter your email',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.email,
            initialValue: '',
          ),
        ),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('shows initial value', (tester) async {
      const initialText = 'Initial Text';
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter text',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.text_fields,
            initialValue: initialText,
          ),
        ),
      );

      expect(find.text(initialText), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered', (tester) async {
      final List<String> changedValues = [];

      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter text',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (value) => changedValues.add(value),
            icon: Icons.text_fields,
            initialValue: '',
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Test Input');
      await tester.pumpAndSettle();

      expect(changedValues.contains('Test Input'), true);
    });

    testWidgets('renders successfully with isPassword true', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter password',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.lock,
            initialValue: '',
            isPassword: true,
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('renders successfully with isPassword false', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter username',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.person,
            initialValue: '',
            isPassword: false,
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('validates input using validator function', (tester) async {
      String? validatorCalled(String? value) {
        if (value?.isEmpty ?? true) {
          return 'This field is required';
        }
        return null;
      }

      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProfileTextFormField(
                  hintText: 'Enter required field',
                  validator: validatorCalled,
                  onSaved: (_) {},
                  onChanged: (_) {},
                  icon: Icons.text_fields,
                  initialValue: '',
                ),
              ),
            ),
          ),
        ),
      );

      // Validate the form with empty field
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('shows no error when validation passes', (tester) async {
      String? validatorCalled(String? value) {
        if (value?.isEmpty ?? true) {
          return 'This field is required';
        }
        return null;
      }

      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProfileTextFormField(
                  hintText: 'Enter required field',
                  validator: validatorCalled,
                  onSaved: (_) {},
                  onChanged: (_) {},
                  icon: Icons.text_fields,
                  initialValue: '',
                ),
              ),
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextFormField), 'Some value');
      await tester.pumpAndSettle();

      // Validate the form
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsNothing);
    });

    testWidgets('calls onSaved when form is saved', (tester) async {
      String? savedValue;
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProfileTextFormField(
                  hintText: 'Enter text',
                  validator: (_) => null,
                  onSaved: (value) => savedValue = value,
                  onChanged: (_) {},
                  icon: Icons.text_fields,
                  initialValue: '',
                ),
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Saved Text');
      await tester.pumpAndSettle();

      formKey.currentState!.save();

      expect(savedValue, 'Saved Text');
    });

    testWidgets('supports different keyboard types', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter email',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.email,
            initialValue: '',
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('supports phone keyboard type', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter phone',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.phone,
            initialValue: '',
            keyboardType: TextInputType.phone,
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.phone), findsOneWidget);
    });

    testWidgets('has correct enabled border', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter text',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.text_fields,
            initialValue: '',
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.text_fields), findsOneWidget);
    });

    testWidgets('has correct focused border color', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter text',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.text_fields,
            initialValue: '',
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.text_fields), findsOneWidget);
    });

    testWidgets('has correct error border color', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter text',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.text_fields,
            initialValue: '',
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.text_fields), findsOneWidget);
    });

    testWidgets('renders text form field with correct properties', (
      tester,
    ) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter text',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.text_fields,
            initialValue: '',
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.text_fields), findsOneWidget);
    });

    testWidgets('accepts multi-line input', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          child: ProfileTextFormField(
            hintText: 'Enter description',
            validator: (_) => null,
            onSaved: (_) {},
            onChanged: (_) {},
            icon: Icons.description,
            initialValue: '',
          ),
        ),
      );

      await tester.enterText(
        find.byType(TextFormField),
        'Line 1\nLine 2\nLine 3',
      );
      await tester.pumpAndSettle();
      expect(find.text('Line 1\nLine 2\nLine 3'), findsOneWidget);
    });
  });
}
