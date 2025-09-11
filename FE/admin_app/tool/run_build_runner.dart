// tool/run_build_runner.dart
import 'dart:io';

// ignore_for_file: avoid_print
Future<void> main() async {
  print(
      '🚀 Running: dart run build_runner build --delete-conflicting-outputs\n');

  try {
    final process = await Process.start(
      'dart',
      ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      runInShell: true,
    );

    // Pipe output directly to terminal
    await stdout.addStream(process.stdout);
    await stderr.addStream(process.stderr);

    final exitCode = await process.exitCode;
    if (exitCode == 0) {
      print('\n✅ build_runner completed successfully.');
    } else {
      print('\n❌ build_runner failed with exit code $exitCode.');
    }
  } catch (e) {
    print('\n❌ Error running build_runner: $e');
  }
}
