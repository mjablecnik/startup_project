import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:project_data/entities/user.dart';
import 'package:project_repository/clients/http_client.dart';
import 'package:project_repository/global.dart';

import 'package:project_repository/repositories/auth_repository.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('AuthBloc test', () async {
    print('Test123:');
    final testVar = 10;
    expect(testVar, 10);
  });
}
