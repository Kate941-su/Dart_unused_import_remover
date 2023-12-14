import 'dart:convert';

import 'test_data.dart';
import 'dart:async';
import 'dart:io';

void main() {
  final unusedImportMapList = getImportMapList(sampleUnusedMessage);
  File file = File(testMapList[0]['filePath']!);
  String fileContent = file.readAsStringSync();

  fileContent =
      getRemoveImportStatement(fileContent, testMapList[0]['packagePath']!);
  file.writeAsStringSync(fileContent);
  print(fileContent);
}

String getRemoveImportStatement(String fileContent, String importStatement) {
  final lines = LineSplitter.split(fileContent).toList();
  print("aaaaaaaaaaimport '$importStatement';");
  lines.removeWhere((it) => it.trim() == "import '$importStatement';");
  return lines.join('\n');
}

List<Map<String, String>> getImportMapList(String message) {
  const filePathIndex = 2;
  const packagePathIndex = 6;
  final messageLines = message.split("\n");
  messageLines.removeLast();

  final List<Map<String, String>> unusedImportMapList = [];
  for (var messageLine in messageLines) {
    final represent = messageLine.split(' ');
    unusedImportMapList.add({
      'filePath': _shapeFilePath(filePath: represent[filePathIndex]),
      'packagePath': _shapePackagePath(packagePath: represent[packagePathIndex])
    });
  }
  return unusedImportMapList;
}

String _shapeFilePath({required String filePath}) {
  return filePath.substring(0, filePath.indexOf(':'));
}

String _shapePackagePath({required String packagePath}) {
  return packagePath.substring(0, packagePath.length - 1);
}
