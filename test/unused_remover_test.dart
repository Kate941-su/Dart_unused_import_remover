import 'package:test/test.dart';
import 'package:unused_import_remover/unused_remover.dart';
import 'dart:io';

const _idealString = 'No issues found!';

void main() {
  group('Unused import remove test\n', () {
    test(
        'The dart file with unused statement directorly under the direcotry (test_file1.dart)',
        () async {
      await executeRemove(['./']);
      final fullPath = 'test/test_file1.dart';
      final analyzeRes = await Process.run('dart', ['analyze', fullPath]);
      String grepRes = '';
      if (analyzeRes.stdout.contains(_idealString)) {
        grepRes = _idealString;
      }
      expect(grepRes, equals(_idealString));
    });
    test(
        'The dart file with unused statement 2 levels under the direcotry (test_file2.dart)',
        () async {
      final fullPath = 'test/test_2/test_file2.dart';
      final analyzeRes = await Process.run('dart', ['analyze', fullPath]);
      String grepRes = '';
      if (analyzeRes.stdout.contains(_idealString)) {
        grepRes = _idealString;
      }
      expect(grepRes, equals(_idealString));
    });
    test(
        'The dart file with unused statement 3 levels under the direcotry (The directories each have different names) (test_file3.dart)',
        () async {
      final fullPath = 'test/test_3/test_3_child/test_file3.dart';
      final analyzeRes = await Process.run('dart', ['analyze', fullPath]);
      String grepRes = '';
      if (analyzeRes.stdout.contains(_idealString)) {
        grepRes = _idealString;
      }
      expect(grepRes, equals(_idealString));
    });
    test(
        'The dart file with unused statement 3 levels under the direcotry (The directories each have same names) (test_file4.dart)',
        () async {
      final fullPath = 'test/test_4/test_4/test_file4.dart';
      final analyzeRes = await Process.run('dart', ['analyze', fullPath]);
      String grepRes = '';
      if (analyzeRes.stdout.contains(_idealString)) {
        grepRes = _idealString;
      }
      expect(grepRes, equals(_idealString));
    });
  });
}
