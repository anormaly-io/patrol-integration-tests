import 'package:flutter/material.dart';
import 'package:patrol_integration_tests/custom_widgets/input_form_widget.dart';

typedef ClickOnSuffixIconAction = Future<void> Function(BuildContext context, bool isValueChanged, String newValue);

class ProfileEditInputTextWidget extends StatefulWidget {
  final String label;
  final String widgetKey;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final IconData icon;
  final ClickOnSuffixIconAction editAction;

  const ProfileEditInputTextWidget({
    super.key,
    required this.label,
    required this.widgetKey,
    required this.controller,
    required this.icon,
    required this.editAction,
    required this.validator,
  });

  @override
  State<ProfileEditInputTextWidget> createState() => _ProfileEditInputTextWidgetState();
}

class _ProfileEditInputTextWidgetState extends State<ProfileEditInputTextWidget> {
  bool _isEditableInputText = false;
  IconData _suffixIcon = Icons.edit;
  final FocusNode _mainFocus = FocusNode();
  final _fieldKey = GlobalKey<FormFieldState>();
  String _initialInputValue = '';

  @override
  Widget build(BuildContext context) {
    _initialInputValue = widget.controller.text;

    return InputFormWidget(
      globalKey: _fieldKey,
      label: widget.label,
      widgetKey: widget.widgetKey,
      controller: widget.controller,
      validator: widget.validator,
      enableTextFormValue: _isEditableInputText,
      inputTextStyle: const TextStyle(
        fontSize: 15.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      bottomMargin: 26,
      prefixIcon: widget.icon,
      suffixIcon: _suffixIcon,
      suffixIconOnPressed: _clickOnEditInputTextAction,
      focusNode: _mainFocus,
    );
  }

  void _clickOnEditInputTextAction() {
    if (_isEditableInputText && !_fieldKey.currentState!.validate()) {
      return;
    }

    widget
        .editAction(context, _initialInputValue != widget.controller.value.text, widget.controller.value.text)
        .then(
          (value) => _switchSuffixIcon(),
        )
        .catchError(
          (error, stackTrace) {},
        );
  }

  void _switchSuffixIcon() {
    setState(() {
      _isEditableInputText = !_isEditableInputText;
      _suffixIcon = _isEditableInputText ? Icons.task_alt : Icons.edit;
    });

    if (_isEditableInputText) {
      FocusScope.of(context).requestFocus(_mainFocus);
    } else {
      FocusScope.of(context).unfocus();
    }
  }
}
