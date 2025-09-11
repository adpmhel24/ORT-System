// import 'dart:io';
// import 'package:path/path.dart' as p;

// final rootDir = Directory('lib/features');

// void main() async {
//   if (!rootDir.existsSync()) {
//     // ignore_for_file: avoid_print
//     print("❌ Feature root not found: ${rootDir.path}");
//     return;
//   }

//   for (var entityFile in rootDir
//       .listSync(recursive: true)
//       .whereType<File>()
//       .where((f) => f.path.endsWith('_entity.dart'))) {
//     generateModelFromEntity(entityFile);
//   }

//   print('✅ All models generated.');
//   await runBuildRunner(); // 👈 Auto-run build_runner
// }

// void generateModelFromEntity(File entityFile) {
//   final entityPath = p.normalize(entityFile.path);
//   final baseName = p.basename(entityPath).replaceAll('_entity.dart', '');
//   final className = _capitalize(baseName);
//   final entityClass = '${className}Entity';
//   final modelClass = '${className}Model';

//   // Get path to the feature root (up to /domain/)
//   final featureDirPath = entityPath.split(RegExp(r'/domain/'))[0];
//   final modelDir = Directory(p.join(featureDirPath, 'data/models'));
//   modelDir.createSync(recursive: true);

//   final modelFilePath = p.join(modelDir.path, '${baseName}_model.dart');

//   // ✅ Skip if file already exists
//   if (File(modelFilePath).existsSync()) {
//     print('⏭️  Skipped (already exists): $modelFilePath');
//     return;
//   }

//   final relativeEntityImport = p.relative(
//     entityPath,
//     from: modelDir.path,
//   );

//   final entityContent = entityFile.readAsStringSync();
//   final fields = _extractFieldNames(entityContent);

//   final buffer = StringBuffer()
//     ..writeln("import 'package:dart_mappable/dart_mappable.dart';")
//     ..writeln()
//     ..writeln("import '$relativeEntityImport';")
//     ..writeln()
//     ..writeln("part '${baseName}_model.mapper.dart';")
//     ..writeln()
//     ..writeln("@MappableClass()")
//     ..writeln(
//         "class $modelClass extends $entityClass with ${modelClass}Mappable {")
//     ..writeln("  const $modelClass({");

//   for (var field in fields) {
//     buffer.writeln("    super.$field,");
//   }

//   buffer
//     ..writeln("  });")
//     ..writeln("}");

//   File(modelFilePath).writeAsStringSync(buffer.toString());

//   print('📝 Generated: $modelFilePath');
// }

// String _capitalize(String input) => input[0].toUpperCase() + input.substring(1);

// List<String> _extractFieldNames(String content) {
//   final regex = RegExp(r'final\s+\w+\??\s+(\w+);');
//   return regex.allMatches(content).map((m) => m.group(1)!).toList();
// }

// Future<void> runBuildRunner() async {
//   print('\n🚀 Running build_runner...');

//   final result = await Process.run(
//     'dart',
//     ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
//     runInShell: true,
//   );

//   if (result.exitCode == 0) {
//     print('✅ build_runner completed successfully.');
//   } else {
//     print('❌ build_runner failed:');
//     print(result.stdout);
//     print(result.stderr);
//   }
// }

import 'dart:io';
import 'package:path/path.dart' as p;

final rootDir = Directory('lib/features');
// ignore_for_file: avoid_print
void main() async {
  if (!rootDir.existsSync()) {
    print("❌ Feature root not found: ${rootDir.path}");
    return;
  }

  for (var entityFile in rootDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('_entity.dart'))) {
    generateModelFromEntity(entityFile);
  }

  print('✅ All models generated.');
  await runBuildRunner();
}

void generateModelFromEntity(File entityFile) {
  final entityPath = p.normalize(entityFile.path);

  final entityContent = entityFile.readAsStringSync();
  final entityClassName = _extractEntityClassName(entityContent);

  if (entityClassName == null) {
    print("❌ Could not find class in: ${entityFile.path}");
    return;
  }

  final modelClassName = entityClassName.replaceAll('Entity', 'Model');
  final baseName = p.basename(entityPath).replaceAll('_entity.dart', '');
  final modelFilePath = p.join(
    entityFile.parent.parent.parent.path,
    'data',
    'models',
    '${baseName}_model.dart',
  );

  if (File(modelFilePath).existsSync()) {
    print('⏭️  Skipped (already exists): $modelFilePath');
    return;
  }

  final modelDir = Directory(p.dirname(modelFilePath));
  modelDir.createSync(recursive: true);

  final relativeEntityImport = p.relative(entityPath, from: modelDir.path);
  final fields = _extractFieldNames(entityContent);

  final buffer = StringBuffer()
    ..writeln("import 'package:dart_mappable/dart_mappable.dart';")
    ..writeln()
    ..writeln("import '$relativeEntityImport';")
    ..writeln()
    ..writeln("part '${baseName}_model.mapper.dart';")
    ..writeln()
    ..writeln("@MappableClass()")
    ..writeln(
        "class $modelClassName extends $entityClassName with ${modelClassName}Mappable {")
    ..writeln("  static const List<String> headers = [");

  for (var field in fields) {
    buffer.writeln("    '$field',");
  }

  buffer
    ..writeln("  ];")
    ..writeln()
    ..writeln("  const $modelClassName({");

  for (var field in fields) {
    buffer.writeln("    super.$field,");
  }

  buffer
    ..writeln("  });")
    ..writeln("}");

  File(modelFilePath).writeAsStringSync(buffer.toString());
  print('📝 Generated: $modelFilePath');
}

// String _capitalize(String input) => input[0].toUpperCase() + input.substring(1);
// String _decapitalize(String input) =>
//     input[0].toLowerCase() + input.substring(1);

String? _extractEntityClassName(String content) {
  final classRegex = RegExp(r'class\s+(\w+Entity)\s+');
  final match = classRegex.firstMatch(content);
  return match?.group(1);
}

List<String> _extractFieldNames(String content) {
  final regex = RegExp(r'final\s+\w+\??\s+(\w+);');
  return regex.allMatches(content).map((m) => m.group(1)!).toList();
}

Future<void> runBuildRunner() async {
  print('\n🚀 Running build_runner...');

  final result = await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    runInShell: true,
  );

  if (result.exitCode == 0) {
    print('✅ build_runner completed successfully.');
  } else {
    print('❌ build_runner failed:');
    print(result.stdout);
    print(result.stderr);
  }
}
