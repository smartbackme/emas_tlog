import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:emas_tlog/emas_tlog.dart';

void main() {
  const MethodChannel channel = MethodChannel('emas_tlog');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
