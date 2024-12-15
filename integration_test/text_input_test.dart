import 'common.dart';

void main() {

  patrol('Test text input', skip: false, ($) async {
    await createApp($);

    await $(#nameSuffixIcon).tap();
    await $(#name).enterText('name 1');
    await $(#nameSuffixIcon).tap();

    await $(#name2).enterText('name 2');
  });

}