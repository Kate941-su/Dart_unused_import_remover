import 'test_data.dart';
import 'dart:io';
import 'dart:convert';

class FileHandler {
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

  String _getRemoveImportStatement(String fileContent, String importStatement) {
    final lines = LineSplitter.split(fileContent).toList();
    print("remove the line 👉 import '$importStatement';");
    lines.removeWhere((it) => it.trim() == "import '$importStatement';");
    return lines.join('\n');
  }
}
