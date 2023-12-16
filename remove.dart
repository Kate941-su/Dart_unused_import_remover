import 'message_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';

void main(List<String> args) async {
  MessageHandler messageHandler;
  if (args.isNotEmpty) {
    messageHandler = MessageHandler(path: args[0]);
  } else {
    messageHandler = MessageHandler();
  }
  // final res = await messageHandler.getAnalyzedMessage();
  final res = await messageHandler.createUnusedMapList();
  // final fileHandler = FileHandler();
  // fileHandler.removeLinesFromFile(unusedImportMapList: res);
}
