import 'dart:async';
import 'package:render/models/history.dart';

class ReceivingState{
  ReceivingState(){

  }
  StreamController acceptMessage = StreamController<String>.broadcast();
  StreamSink<String> get writeMessage => acceptMessage.sink;
  Stream<String> get getMessage => acceptMessage.stream;

  StreamController recFile = StreamController<String>.broadcast();
  StreamSink<String> get sendResp => recFile.sink;
  Stream<String> get getResp => recFile.stream;

  StreamController recFileSize = StreamController<double>.broadcast();
  StreamSink<double> get getFileSizeIn => recFileSize.sink;
  Stream<double> get getFileSize => recFileSize.stream;

  StreamController writingFile = StreamController<String>();
  StreamSink<String> get fileWritenIn => writingFile.sink;
  Stream<String> get fileWritten => writingFile.stream;

  StreamController fileobj = StreamController<HistoryModel>.broadcast();
  StreamSink<HistoryModel> get getJsonObjIn => fileobj.sink;
  Stream<HistoryModel> get getJsonObj => fileobj.stream;
  
  void dispose(){
    acceptMessage.close();
    recFile.close();
  }
}