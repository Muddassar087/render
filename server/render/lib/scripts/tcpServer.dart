import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:render/models/history.dart';
import 'package:render/scripts/ServerState.dart';
import 'package:render/scripts/receiveingState.dart';
import 'package:render/scripts/writeFiles.dart';

class TCPServer {
  ServerSocket socket;
  final int port;
  ServerStatusBloc serverState = null;
  ReceivingState recState = null;
  final fileTypes = ["image", "doc", "video"];

  TCPServer({this.port});

  Future<ServerSocket> bindto(int port) async {
    return ServerSocket.bind(InternetAddress.anyIPv4, port);
  }

  get getInstance => this.socket;

  void startServer(serverS, receS) async {
    BytesBuilder builder = new BytesBuilder(copy: false);
    serverState = serverS;
    recState = receS;
    double size = null;
    String _filetype = null;
    String _fileName = null;

    try{
      await bindto(port).then((server) {
        print("server started at ${server.address}");
        server.listen((client) {
          client.listen((event) async {
            try{
              final text = ascii.decode(event);
              if(text.contains("size") || text.contains("type")){
                print("in $text");
                final obj = json.decode(text);
                size = obj['size'];
                _fileName = obj['fileName'];
                _filetype = obj['type'];
                HistoryModel model = HistoryModel(dateTime: DateTime.now(), name: _fileName, type: _filetype);
                recState.getJsonObjIn.add(model);
                client.write("START SENDING");
            }}catch(exp){
              builder.add(event);
              print(builder.length/1024/1024);
              double perc = ((builder.length/1024/1024)/size);
              recState.getFileSizeIn.add(perc);
            }
          }, onError: (err) {
            print("::client closed::");
          }, 
          onDone: () {
            saveFile(fileName: _fileName, fileType: _filetype, bytes: builder.takeBytes());
            builder.clear();
            client.close();
          });
        });
      });
    }catch(err){
      print("::server not created::");
    }
  }

  closeConnection() {
    this.socket.close();
  }
}
