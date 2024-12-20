import 'package:flutter/material.dart';

class InputFocus extends StatefulWidget {
  const InputFocus({super.key});

  @override
  State<InputFocus> createState() => _InputFocusState();
}

class _InputFocusState extends State<InputFocus> {
  final TextEditingController input1Controller = TextEditingController(text: 'aoe');
  final TextEditingController input2Controller = TextEditingController(text: 'aoe');
  var readOnly = true;
  final FocusNode _mainFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Input title'),
      ),
      body: Column(
        children: [
          TextFormField(
            key: const Key('input1'),
            controller: input1Controller,
            readOnly: readOnly,
            focusNode: _mainFocus,
          ),
          TextFormField(
            key: const Key('input2'),
            controller: input2Controller,
          ),
          ElevatedButton(
            key: const Key('button'),
            onPressed: () {
              readOnly = !readOnly;

              if (!readOnly) {
                FocusScope.of(context).requestFocus(_mainFocus);
              } else {
                FocusScope.of(context).unfocus();
              }
            },
            child: const Text('enable/disable input'),
          )
        ],
      ),
    );
  }
}
