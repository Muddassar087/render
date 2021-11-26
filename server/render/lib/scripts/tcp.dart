import 'dart:convert';
import 'dart:io';

// import 'dart:typed_data';
// import 'dart:typed_data';

class TCP{  
  Socket socket;
  final int port;

  TCP({this.port});

  Future bindto(int port) async {
    try{
      this.socket = await Socket.connect(InternetAddress.anyIPv4, this.port);
      
    }catch(SocketException){
      print("No server found with port: ${this.port}");
      return null;
    }
  }

  get getInstance => this.socket;

  Future<void> send(data) async {
    if (this.socket == null) await bindto(port);
    this.socket.write(data);
  }

  Future<void> receive() async {
    File file = await File("img.jpg");

    this.socket.listen(
      (event) async{
        final data = (event);
        try{
          final text = ascii.decode(data);
          print(text);
          if(text == "ACCEPTED"){
            await send("RECEIVED");
          }
          else if (text.contains("Do you want")){
            await send("y");
          }
        }catch(err){
          // receiveFile(file, data);
        }
      },
      onError: (err){print("some error in server");},
      onDone: (){
        print("server close");
        closeConnection();
      }
    );
  }

  void receiveFile() async {
    // File file = File("img.jpg");
    // List packetdata;
    // final size = 629;
    this.socket.listen((event) async {
      try{
        final data = ascii.decode(event);
        print("${(int.parse(data)/1024)}kb");
      }catch(err){
      // packetdata = (new Uint8List.fromList(event).buffer.asUint8List());
      }
    },
    onError: (err){print(err);},
    onDone: (){
      // print(packetdata);
      // file.writeAsBytes(packetdata, mode:FileMode.writeOnlyAppend);
      closeConnection();
      }
    );
  }

  closeConnection(){
    this.socket.close();
  }
}