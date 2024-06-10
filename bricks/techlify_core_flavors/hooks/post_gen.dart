import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final appName = context.vars['appName'].toString().snakeCase;
  final appDirectory = Directory('${Directory.current.path}/$appName');

  final cdCommand = 'cd $appDirectory';

  // Add dependencies
  await Future.wait([
    Process.run('bash', ['-c', '$cdCommand && flutter pub add bloc']),
    Process.run('bash', ['-c', '$cdCommand && flutter pub add flutter_bloc']),
    Process.run('bash', ['-c', '$cdCommand && flutter pub add equatable']),
  ]);

  // Get dependencies
  await Process.run('bash', ['-c', '$cdCommand && flutter pub get']);
}
