import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_integration_tests/main.dart';

typedef BeforeStartTheAppFunction = Future<void> Function();

const _patrolTesterConfig = PatrolTesterConfig();
const _nativeAutomatorConfig = NativeAutomatorConfig(
  findTimeout: Duration(seconds: 20), // 10 seconds is too short for some CIs
);

Future<void> createApp(PatrolIntegrationTester $, {BeforeStartTheAppFunction? beforeStartTheAppFunction}) async {
  if(beforeStartTheAppFunction != null) {
    await beforeStartTheAppFunction();
  }

  await $.pumpWidgetAndSettle(
    const MyApp(),
  );
}

void patrol(
  String description,
  Future<void> Function(PatrolIntegrationTester) callback, {
  bool? skip,
  List<String> tags = const [],
  NativeAutomatorConfig? nativeAutomatorConfig,
  LiveTestWidgetsFlutterBindingFramePolicy framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fadePointers,
}) {
  patrolTest(
    description,
    config: _patrolTesterConfig,
    nativeAutomatorConfig: nativeAutomatorConfig ?? _nativeAutomatorConfig,
    framePolicy: framePolicy,
    skip: skip,
    callback,
    tags: tags,
  );
}
