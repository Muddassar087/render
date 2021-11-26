import 'tcpServer.dart';

class TCPImplementation{
  TCPServer tcp;
  final int port;
  TCPImplementation({this.port}){
    tcp = new TCPServer(port: this.port);
  }
  void startServer(bloc, rescS) async {
    tcp.startServer(bloc, rescS);
  }
}