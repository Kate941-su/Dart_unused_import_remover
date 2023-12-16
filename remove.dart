import 'message_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';
import 'file_handler.dart';

void main() async {
  final res = await MessageHandler().getOriginalAnalyzeMessage();
  print(res);
  // FileHandler().testRemoveLinesFromFile();
  // MessageHandler().testCreateMessage();
}
