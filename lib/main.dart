import 'package:flutter/material.dart';
import 'package:patrol_integration_tests/custom_widgets/input_form_widget.dart';
import 'package:patrol_integration_tests/custom_widgets/profile_edit_input_text_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nameController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(children: [
        ProfileEditInputTextWidget(
          label: 'Name',
          widgetKey: 'name',
          controller: nameController,
          icon: Icons.person,
          validator: (name) => InputFormWidget.validateName(name, context),
          editAction: _editNameAction,
        ),
        InputFormWidget(
          label: 'Name',
          widgetKey: 'name2',
          validator: (name) => InputFormWidget.validateName(name, context),
          controller: nameController2,
        ),
      ],),

    );
  }

  Future<void> _editNameAction(BuildContext context, bool isValueChanged, String updatedName) async {
    //when it's not in edit mode we save the updated name
    if (isValueChanged) {
      print('name changed');
    }
  }
}
