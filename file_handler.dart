import 'test_data.dart';
import 'dart:io';
import 'dart:convert';

class FileHandler {
  void removeLinesFromFile({required List unusedImportMapList}) {
    for (Map<String, dynamic> unusedImportMap in unusedImportMapList) {
      final filePath = unusedImportMap['filePath']!;
      print('💪start deleting $filePath');
      File file = File(filePath);
      String fileContent = file.readAsStringSync();
      for (final packagePath in unusedImportMap['packagePath']!) {
        fileContent = _getRemoveImportStatement(fileContent, packagePath);
      }
      file.writeAsStringSync(fileContent);
      print('🦾finish deleting $filePath\n');
    }
  }

  String _getRemoveImportStatement(String fileContent, String importStatement) {
    final lines = LineSplitter.split(fileContent).toList();
    final trimmedDotStatement = _trimLastDot(importStatement);
    final statement = 'import $trimmedDotStatement;';
    print("Delete the line 🗑️ $statement");
    lines.removeWhere((it) {
      return it.trim() == statement;
    });
    return lines.join('\n');
  }

  String _trimLastDot(String importStatement) {
    if (importStatement.endsWith('.')) {
      return importStatement.substring(0, importStatement.length - 1);
    }
    return importStatement;
  }

  // test methods
  void testRemoveLinesFromFile() {
    for (Map<String, dynamic> testMap in testMapList) {
      final filePath = testMap['filePath']!;
      print('💪start $filePath💪');
      File file = File(filePath);
      String fileContent = file.readAsStringSync();
      for (final packagePath in testMap['packagePath']!) {
        fileContent = _getRemoveImportStatement(fileContent, packagePath);
      }
      file.writeAsStringSync(fileContent);
    }
  }
}
