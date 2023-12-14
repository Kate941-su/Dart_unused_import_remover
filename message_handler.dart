import 'test_data.dart';

class MessageHandler {
  void testCreateMessage() {
    final unusedImportMapList = _getImportMapList(sampleUnusedMessage);
    for (final line in unusedImportMapList) {
      print(line);
    }
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
