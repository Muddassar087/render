import 'dart:convert';
import 'dart:io';
import '__init__.dart';

int i = 0;
class UDPclient {
	RawDatagramSocket datagram = null;
	UDPclient({this.datagram});

	
	Future<UDPclient> bind() async {
		final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, PORT, reusePort: false);
		return UDPclient(datagram: socket);
	}

	Future<int> send(String message) async {
		return this.datagram.send(ascii.encode(message), HOST, 5000);
	}

	void receive() async{
		this.datagram.listen(
			(event){
				if(event==RawSocketEvent.read){
					print(ascii.decode(this.datagram.receive().data));
				}
			},
			onError: ((err){print(err);}),
			onDone: (){}
		);
	}
}
class UDPClientImplementation{
	static UDPclient client = null;

	static bool isConnected(){
		if(client!=null)
			return true;
		return false;
	}

	static void connectToServer() async{
		client = await UDPclient().bind();
	}

	static Future<int> send() async{
		if(client.datagram!=null){
			return client.datagram.send(ascii.encode("message"), InternetAddress.anyIPv4, 5000);
		}
		return 0;
	}

	static closeConnection(){
		client.datagram.close();
	}
}