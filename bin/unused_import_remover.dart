import 'lib/file_handler.dart';
import 'lib/message_handler.dart';

void main(List<String> args) async {
  await executeRemove(args);
}

Future<void> executeRemove(List<String> args) async {
  MessageHandler messageHandler;
  if (args.isNotEmpty) {
    messageHandler = MessageHandler(path: args[0]);
  } else {
    messageHandler = MessageHandler();
  }
  // final res = await messageHandler.getAnalyzedMessage();
  final res = await messageHandler.createUnusedMapList();
  if (messageHandler.hasRemovingLine(res)) {
    final fileHandler = FileHandler();
    fileHandler.removeLinesFromFile(unusedImportMapList: res);
  } else {
    print('Your project has no unused package statement. Awesome!!');
  }
}
