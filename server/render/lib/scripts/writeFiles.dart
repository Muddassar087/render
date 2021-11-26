import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveFile({fileType,fileName, bytes}) async{
  Directory directory;
  String finalPath = "";
  if(fileName == null || fileType == null)
    return;
  try{
    if(Platform.isAndroid){
      if (await _requestPermission(Permission.storage)) {
        directory = await getExternalStorageDirectory();
        List<String> list = directory.absolute.path.split("/");
        for(int i = 1; i<list.length; i++){
          if (list[i] != "Android")
            finalPath += "/"+list[i];
          else
            break;
        }
      }
      print(finalPath);
      switch (fileType) {
        case "image":
          finalPath = "$finalPath/Iamges";
          break;
        case "video":
          finalPath = "$finalPath/Video";
          break;
        case "doc":
          finalPath = "$finalPath/Documents";
          break;
      }
      directory = Directory(finalPath);
      if(!await directory.exists()){
        await directory.create(recursive: true);
      }
      File file = File("${directory.path}/$fileName");
      final res = await file.writeAsBytes(bytes, mode:FileMode.writeOnlyAppend);
      if(res!=null){
        return true;
      }
    }
  }catch(err){print(err.toString());
  }
  return false;
}
Future<bool> _requestPermission(Permission permission) async{
 if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
}