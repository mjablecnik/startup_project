import 'dart:io';
import 'package:yaml/yaml.dart';

class AppInfo {
  dynamic get _pubspec {
    final file = File('${_projectRoot(file: 'pubspec.yaml')}/pubspec.yaml');
    final yamlString = file.readAsStringSync();
    return loadYaml(yamlString);
  }

  List<String> get gitScope {
    final file = File('${_projectRoot(file: '.gitscope')}/.gitscope');
    return file.readAsLinesSync();
  }

  String _projectRoot({required String file}) {
    Directory root = Directory.current;

    while (root.path.isNotEmpty && !File('${root.path}/$file').existsSync()) {
      root = root.parent;
    }

    return root.path;
  }

  Future<String> get version => _pubspec['version'];

  Future<String> get name  => _pubspec['name'];
}
