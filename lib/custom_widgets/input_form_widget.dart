import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:patrol_integration_tests/custom_widgets/icon_with_background_color.dart';
import 'package:patrol_integration_tests/custom_widgets/suffix_icon_colored.dart';

class InputFormWidget extends StatefulWidget {
  String? widgetKey;
  final Key? globalKey;
  final String label;
  final String? textFormValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enableTextFormValue;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconOnPressed;
  final bool suffixIconWithBackground;
  final FloatingLabelBehavior floatingLabelBehavior;
  final FocusNode? focusNode;
  final TextStyle? inputTextStyle;
  final double bottomMargin;

  InputFormWidget({super.key,
    this.globalKey,
    this.widgetKey,
    required this.label,
    this.textFormValue,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enableTextFormValue = true,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.suffixIconWithBackground = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.focusNode,
    this.inputTextStyle,
    this.bottomMargin = 20,
  }) {
    widgetKey = widgetKey ?? label.toLowerCase();
  }

  @override
  State<InputFormWidget> createState() => _InputFormWidgetState();

  static String? validateName(String? name, BuildContext context) {
    String failValidationMessage = 'Enter valid name, only one word and only letters';
    if (name?.isEmpty ?? true) {
      return failValidationMessage;
    } else {
      RegExp regex = RegExp(r'^[A-Za-z]+$');
      if (!regex.hasMatch(name!)) {
        return failValidationMessage;
      }
    }

    return null;
  }

  static String? validateEmail(String? email, BuildContext context) {
    return email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null;
  }

  static String? validatePassword(String? password, BuildContext context) {
    if (password != null && password.length < 7) {
      return 'Enter min. 7 characters';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? confirmPassword, String? password, BuildContext context) {
    if (password != null && password != confirmPassword) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  static String? validateRequiredAge(bool? value, BuildContext context) {
    if (value != null && value) {
      return null;
    } else {
      return 'You must be at least 18 years old to create an account.';
    }
  }
}

class _InputFormWidgetState extends State<InputFormWidget> {
  bool _showPassword = false;
  double _iconSize = 0;

  @override
  void initState() {
    super.initState();
    _showPassword = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    _iconSize = (MediaQuery.of(context).size.height * 0.030) - 4;

    return Column(
      children: [
        SizedBox(
          // if global key is present (for form validation reason), we assign the parent of the text form the widget key, so we can use in the testing
          key: (widget.globalKey != null) ? Key(widget.widgetKey!) : null,
          width: double.infinity,
          child: TextFormField(
            key: widget.globalKey ?? Key(widget.widgetKey!),
            initialValue: widget.textFormValue,
            controller: widget.controller,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            textInputAction: TextInputAction.next,
            //disable the input text form value to be changed
            readOnly: !widget.enableTextFormValue,
            focusNode: widget.focusNode,
            obscureText: !_showPassword,
            style: widget.inputTextStyle ?? const TextStyle(
              fontSize: 14.0,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(201, 201, 201, 1),
            ),
            decoration: _inputTextDecoration(),
          ),
        ),
        SizedBox(
          height: widget.bottomMargin,
        ),
      ],
    );
  }

  InputDecoration _inputTextDecoration() {
    return InputDecoration(
      prefixIcon: widget.prefixIcon == null ? null : _prefixIcon(widget.prefixIcon),
      suffixIcon: _resolveSuffixIcon(),
      border: _resolveInputBorder(),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: widget.floatingLabelBehavior,
      labelStyle: const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(201, 201, 201, 1),
      ),
      labelText: widget.label,
      errorStyle: const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(246, 64, 113, 1),
      ),
    );
  }

  InputBorder? _resolveInputBorder() {
    BorderRadius borderRadius = BorderRadius.circular(10.0);
    BorderSide borderSide = const BorderSide(
      width: 0,
      style: BorderStyle.none,
    );

    InputBorder? inputBorder;
    //if we don't show the label, then to hide the borders we need OutlineInputBorder
    //or with label visible, then to hide the borders we need to use UnderlineInputBorder
    if (widget.floatingLabelBehavior == FloatingLabelBehavior.never) {
      inputBorder = OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      );
    } else if (widget.floatingLabelBehavior == FloatingLabelBehavior.always) {
      inputBorder = UnderlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      );
    }

    return inputBorder;
  }

  Widget? _resolveSuffixIcon() {
    Widget? suffixIcon;
    if (widget.suffixIcon != null) {
      suffixIcon = _suffixIconButton(widget.suffixIcon!, widget.suffixIconOnPressed);
    } else if (widget.obscureText) {
      //in case we want to allow the user to see the password
      IconData visibilityIcon = _showPassword ? Icons.visibility : Icons.visibility_off;
      suffixIcon = _suffixIconButton(
        visibilityIcon,
        () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
      );
    }

    return suffixIcon;
  }

  Widget _suffixIconButton(IconData iconData, VoidCallback? onPressedAction) {
    Widget suffixIcon;

    if (widget.suffixIconWithBackground) {
      suffixIcon = IconWithBackground(
        backgroundColor: const Color.fromRGBO(246, 64, 113, 1),
        backgroundMargin: 13.5,
        icon: SuffixIconColored(
          parentKey: widget.widgetKey,
          iconSize: _iconSize,
          icon: iconData,
          iconColor: const Color.fromRGBO(246, 64, 113, 1),
          onPressedAction: onPressedAction,
        ),
      );
    } else {
      suffixIcon = SuffixIconColored(
        parentKey: widget.widgetKey,
        iconSize: _iconSize,
        icon: iconData,
        iconColor: const Color.fromRGBO(246, 64, 113, 1),
        onPressedAction: onPressedAction,
      );
    }

    return suffixIcon;
  }

  Widget _prefixIcon(IconData? prefixIcon) {
    Color inputTextSecondColor = const Color.fromRGBO(246, 64, 113, 1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.only(top: 6, bottom: 6, right: 10),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 0.6,
            color: inputTextSecondColor,
          ),
        ),
      ),
      child: Icon(
        prefixIcon,
        color: inputTextSecondColor,
        size: _iconSize,
      ),
    );
  }
}
