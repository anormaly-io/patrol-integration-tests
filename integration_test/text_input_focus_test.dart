import 'common.dart';

void main() {

  patrol('Test text input focus', skip: false, ($) async {
    await createApp($);

    await $(#input2).enterText('input value 2');

    await $(#button).tap();
    await $(#input1).enterText('input value 1');
    await $(#button).tap();
  });
}