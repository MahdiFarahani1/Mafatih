import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class AudioSave {
  static Future<String> getApplicationDocumentsDirectoryPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return appDocPath;
  }

  static Future<void> downloadFile(
    String url,
  ) async {
    try {
      String savePath = await getApplicationDocumentsDirectoryPath();
      await Dio().download(url, "$savePath/save_file.mp3");
      print("download is done ---------------------------");
    } catch (e) {
      print('Error downloading file: $e');
    }
  }
//  static Future<void> playLocalFile(String filePath,AudioPlayer audioPlayer) async {

//   int result = await audioPlayer.play(filePath, isLocal: true,);
//   if (result == 1) {
//     print('File played successfully.');
//   } else {
//     print('Error playing file.');
//   }
// }
}
