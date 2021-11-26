import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:render/main.dart';
import 'package:render/scripts/ServerState.dart';

// ignore: must_be_immutable
class Server extends StatefulWidget {
  ServerStatusBloc serverState;

  Server({this.serverState}) {
  }

  String serverStatus = "connected";
  int port = 5000;
  String host = "local IP address";

  @override
  _ServerState createState() => _ServerState();
}

class _ServerState extends State<Server> {
  @override
  void initState() {
    super.initState();
     Future.delayed(Duration(seconds: 1)).then((val){
        setState(() {
          connected = true;
        });
      });
  }

  bool connected = false;
  bool test = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: connected ? 
        Text("Connection made",
          style: TextStyle(
            fontFamily: "Roboto",
            color: primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none)):
        CircularProgressIndicator(
          color: primaryDark,
        )
    );
  }
}
