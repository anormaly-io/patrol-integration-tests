import 'package:flutter/material.dart';
import 'package:patrol_integration_tests/custom_widgets/input_form_widget.dart';
import 'package:patrol_integration_tests/custom_widgets/profile_edit_input_text_widget.dart';

class InputScreen extends StatelessWidget {
  InputScreen({super.key});

  final TextEditingController nameController = TextEditingController(text: 'ouoe');

  final TextEditingController nameController2 = TextEditingController(text: 'ouoe');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Input title'),
      ),
      body: Column(
        children: [
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
        ],
      ),
    );
  }

  Future<void> _editNameAction(BuildContext context, bool isValueChanged, String updatedName) async {
    //when it's not in edit mode we save the updated name
    if (isValueChanged) {
      print('name changed');
    }
  }
}
