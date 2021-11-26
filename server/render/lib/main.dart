import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:render/scripts/ServerState.dart';
import 'package:render/scripts/receiveingState.dart';
import 'package:render/scripts/tcpImplementation.dart';
import './widgets/button.dart';
import './widgets/receiver.dart';
import './widgets/server.dart';
import './widgets/dialogue.dart';
import 'models/history.dart';

const primaryColor = const Color.fromRGBO(62, 118, 121, 0.67);
const popupprimary = const Color.fromRGBO(238, 238, 238, 1);
const primaryDark = const Color.fromRGBO(62, 118, 121, 1);
final _serverState = ServerStatusBloc();
final _recState = ReceivingState();


void main(){
  TCPImplementation tcp = TCPImplementation(port: 5000);
  tcp.startServer(_serverState, _recState);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto",
        primaryColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Render'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController animController;
  String fileName;
  String fileType;

  @override
  void initState() {
    super.initState();
    _recState.getJsonObj.listen((event) {
      fileName = event.getName;
      fileType = event.getType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: (){
              DialogueGeneral(callback: Receiver(recState: _recState,fileName: fileName, fileType: fileType,),heightContainer: 170).genDailogue(context);
            },
            tooltip: "Receive",icon: new Image(image: AssetImage("assets/images/download.png"))),
        ],
      ),
      body: Container(child: History(context: context))
    );
  }
}

// ignore: must_be_immutable
class History extends StatefulWidget{

  History ({this.context}){}

  BuildContext context;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryModel> history = historyModels;
  BuildContext cont;

  void initState(){
    super.initState();
     _recState.getMessage.listen((event){
       print(event);
      if(event != null){
        DialogueGeneral(callback: acceptMessage(event),heightContainer: 120).genDailogue(context);
      }
    });
    _serverState.serverstatus.listen((event) {
      if(event){
        print(event);
        DialogueGeneral(callback: Server(), heightContainer: 100).genDailogue(context);
      }if(!event){
        if(Navigator.canPop(context)){
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    cont = context;
    return SizedBox(
      child: Column(
        children: [
          headings(),
          list()
        ],
      ),
    );
  }

  Widget headings(){
    return (
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text("Your history", style: TextStyle(fontFamily: "Roboto", fontSize: 24.0, color: primaryColor,fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Image(image: AssetImage("assets/images/history.png")),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OutlinedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Color.fromRGBO(62, 118, 121, 0.67), width: 1.5)),
                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))
              ),
              onPressed: (){
                DialogueGeneral(callback: clearAll(), heightContainer: 120).genDailogue(widget.context);
            }, child: new Text("clear all", style: TextStyle(fontSize: 15.0, color: primaryColor))) 
          ),
          
        ],
      )
    );
  }

  Widget clearAll(){
      return Column(
        textDirection: TextDirection.ltr,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text("Are you sure you want to clear all?", 
                style: TextStyle(fontFamily: "Roboto", color: primaryDark, fontSize: 17, fontWeight: FontWeight.normal,decoration: TextDecoration.none)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0)
                    ),
                    child: Button(color: Colors.transparent,text: "Cancel", textColor:primaryDark, callback: (){Navigator.pop(context);},)
                  ),
                ),
              Button(color: primaryDark, text:"Yes", textColor: Colors.white, callback: (){
                Navigator.pop(context);})
              ],
            ),
          )
        ],
      );
  }
   Widget acceptMessage(msg){
      return Column(
        textDirection: TextDirection.ltr,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text("${msg}", 
                style: TextStyle(fontFamily: "Roboto", color: primaryDark, fontSize: 17, fontWeight: FontWeight.normal,decoration: TextDecoration.none)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0)
                    ),
                    child: Button(color: Colors.transparent,text: "Cancel", textColor:primaryDark, callback: (){
                      _recState.sendResp.add("n");
                      Navigator.pop(context);
                    },)
                  ),
                ),
              Button(color: primaryDark, text:"Yes", textColor: Colors.white, callback: (){
                  _recState.sendResp.add("y");
                  Navigator.pop(context);
                })
              ],
            ),
          )
        ],
      );
    }


  Widget list(){
    return Expanded(
      child: Scrollbar(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  history.map((e) => ExpansionTile(
                    title: Text("${e.getName}", style: TextStyle(fontSize:18,color: Color.fromRGBO(0, 0, 0, 0.62),),),
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                child: new Text("${e.getDateTime}", style: TextStyle(fontSize:15,color: Color.fromRGBO(0, 0, 0, 0.62),),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                                child: Text("${e.getType}", style: TextStyle(fontSize:15,color:primaryDark,),),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,20,5),
                            child: Container(
                              height: 30,
                              width: 70,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                                  backgroundColor: MaterialStateProperty.all<Color>(primaryDark),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
                                ),
                                onPressed: (){
                                  setState(() {
                                    history.removeAt(0);
                                  });
                                },
                                child: const Text('Delete',style: TextStyle(fontSize:14)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )).toList()
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}