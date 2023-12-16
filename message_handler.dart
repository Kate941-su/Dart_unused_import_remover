import 'package:glob/list_local_fs.dart';

import 'test_data.dart';
import 'dart:io';
import 'package:glob/glob.dart';
import 'dart:convert';

class MessageHandler {
  Future<String> getOriginalAnalyzeMessage() async {
    var pattern = Glob('*.dart');
/**
 * What does the one line command execute ?
pattern: This is an instance of the Glob class from the glob package. 
         It represents a pattern for matching file paths.

listSync(): This method is called on the Glob instance (pattern) and returns a list of file system entities (files and directories) that match the specified pattern. 
            It's a synchronous method, meaning it blocks until it completes.

whereType<File>(): This is a filtering step. It filters the list of file system entities to only include those that are of type File. 
                   It ensures that only files, not directories, are included in the result.

map((file) => file.path): This maps each File object to its path. 
              It transforms the list of File objects into a list of strings representing their paths.
 */
    var filePathList =
        pattern.listSync().whereType<File>().map((file) => file.path);
    final args = ['analyze', ...filePathList];
    final analyzeRes = await Process.run('dart', args);
    final res =
        _grepKeyword(content: analyzeRes.stdout, keyWord: 'unused_import');
    return res;
  }

  void testCreateMessage() {
    final unusedImportMapList = _getImportMapList(sampleUnusedMessage);
    for (final line in unusedImportMapList) {
      print(line);
    }
  }

  String _grepKeyword({required String content, required String keyWord}) {
    final strLines = LineSplitter.split(content).toList();
    final resList = strLines.where((it) => it.contains('unused_import'));
    String res = '';
    resList.forEach((it) {
      res = res + '$it\n';
    });
    return res;
  }

  List<Map<String, dynamic>> _getImportMapList(String message) {
    const filePathIndex = 2;
    const packagePathIndex = 6;
    final messageLines = message.split("\n");
    messageLines.removeLast();

    final List<Map<String, dynamic>> unusedImportMapList = [];

    var packagePathList = [];
    var previousFilePath = '';
    var lastFilePath = '';
    var lastPackagePathList = [];

    for (var messageLine in messageLines) {
      final represent = messageLine.split(' ');
      final filePath = _shapeFilePath(filePath: represent[filePathIndex]);
      if (previousFilePath == filePath) {
        packagePathList
            .add(_shapePackagePath(packagePath: represent[packagePathIndex]));
      } else {
        if (previousFilePath.isNotEmpty) {
          unusedImportMapList.add(
              {'filePath': previousFilePath, 'packagePath': packagePathList});
          packagePathList = [];
          packagePathList
              .add(_shapePackagePath(packagePath: represent[packagePathIndex]));
        } else {
          //For add initialize list
          packagePathList.add(filePath);
        }
      }
      previousFilePath = filePath;
      lastFilePath = filePath;
      lastPackagePathList = packagePathList;
    }
    unusedImportMapList
        .add({'filePath': lastFilePath, 'packagePath': lastPackagePathList});
    return unusedImportMapList;
  }

  String _shapeFilePath({required String filePath}) {
    return filePath.substring(0, filePath.indexOf(':'));
  }

  String _shapePackagePath({required String packagePath}) {
    return packagePath.substring(0, packagePath.length - 1);
  }
}
