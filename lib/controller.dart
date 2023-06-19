import 'package:flutter_riverpod/flutter_riverpod.dart';

class dirNotifier extends StateNotifier<String> {
  dirNotifier() : super('/storage/emulated/0');

  void changeDirectory(String path) {
    state = path;
  }
}

// void setValue (bool value)=> value = value;

final dirProvider =
    StateNotifierProvider<dirNotifier, String>((ref) => dirNotifier());

class dirNameNotifier extends StateNotifier<String> {
  dirNameNotifier() : super('root Directory');

  void changeFolder(String folder) {
    state = folder;
  }
}

final dirNameProvider =
    StateNotifierProvider<dirNameNotifier, String>((ref) => dirNameNotifier());


// void parentDirectory()=> ref.read(dirProvider.notifier).changeDirectory(
//     ref.read(dirProvider).split('/').sublist(0, ref.read(dirProvider).split('/').length - 1).join('/'));