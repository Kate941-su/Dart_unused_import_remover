import 'package:glob/list_local_fs.dart';
import 'dart:io';
import 'package:glob/glob.dart';
import 'dart:convert';

import 'progress.dart';

const String _suffixPath = '/**.dart';
const int _filePathIndex = 2;
const int _packagePathIndex = 6;
const String _unusedImportStatement =
    ' Try removing the import directive. - unused_import';

class MessageHandler {
  String? path;

  MessageHandler({this.path});

  Future<List> createUnusedMapList() async {
    final analyzedMessage = await _getAnalyzedMessage();
    final unusedImportMapList = _getImportMapList(analyzedMessage);
    return unusedImportMapList;
  }

  bool hasRemovingLine(List unusedImportMapList) {
    if (unusedImportMapList.isEmpty) {
      return false;
    } else if (unusedImportMapList.length == 1 &&
        unusedImportMapList[0]['filePath'].isEmpty) {
      return false;
    }
    return true;
  }

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
  Future<String> _getAnalyzedMessage() async {
    var pattern = Glob('../**.dart');
    if (path != null) {
      pattern = Glob('$path$_suffixPath');
    }
    var filePathList =
        pattern.listSync().whereType<File>().map((file) => file.path);
    var res = '';
    final fileCount = filePathList.length;
    var count = 0;
    print('Searching unused import statements 👀');
    for (final filePath in filePathList) {
      final args = ['analyze', filePath];
      final analyzeRes = await Process.run('dart', args);
      res += _grepKeyword(
          content: analyzeRes.stdout,
          keyWord: 'unused_import',
          fullPath: filePath);
      count += 1;
      showProgress(progressCount: count, totalCount: fileCount);
    }
    print('\nFinish searching 🎉');
    return res;
  }

  String _grepKeyword(
      {required String content,
      required String keyWord,
      required String fullPath}) {
    final strLines = LineSplitter.split(content).toList();
    final resList = strLines.where((it) => it.contains(_unusedImportStatement));
    String res = '';
    resList.forEach((it) {
      var relativePath = it.split(' ')[_filePathIndex];
      final keyword = it.replaceFirst(relativePath, fullPath);
      res = res + '$keyword\n';
    });
    return res;
  }

  List<Map<String, dynamic>> _getImportMapList(String message) {
    final messageLines = message.split("\n")..removeLast();

    final List<Map<String, dynamic>> unusedImportMapList = [];

    var packagePathList = [];
    var previousFilePath = '';
    var lastFilePath = '';
    var lastPackagePathList = [];

    for (var messageLine in messageLines) {
      final represent = messageLine.split(' ');
      final filePath = represent[_filePathIndex];
      if (previousFilePath == filePath) {
        packagePathList
            .add(_shapePackagePath(packagePath: represent[_packagePathIndex]));
      } else {
        if (previousFilePath.isNotEmpty) {
          unusedImportMapList.add(
              {'filePath': previousFilePath, 'packagePath': packagePathList});
          packagePathList = []
            ..add(_shapePackagePath(packagePath: represent[_packagePathIndex]));
        } else {
          //For add initialize list
          packagePathList.add(represent[_packagePathIndex]);
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

  String _shapePackagePath({required String packagePath}) {
    return packagePath.substring(0, packagePath.length - 1);
  }
}
