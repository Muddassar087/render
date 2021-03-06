import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:render/main.dart';
import 'package:render/scripts/receiveingState.dart';
import 'package:render/widgets/button.dart';

// ignore: must_be_immutable
class Receiver extends StatefulWidget {

  Receiver({Key key, this.recState, this.fileName, this.fileType}) : super(key: key);
  ReceivingState recState;
  String fileName;
  String fileType;
 
  @override
  _ReceiverState createState() => _ReceiverState();
}

class _ReceiverState extends State<Receiver> {
  bool recSatus;
  double recValue = 0.5;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return StreamBuilder<double>(
        stream: widget.recState.getFileSize,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: Text("waiting",
              style: TextStyle(
                fontFamily: "Roboto", 
                color: primaryDark,
                fontSize: 20.0, 
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none))); 
          }
          return Column(
            children: [
               Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
                child: Row(
                  children: [
                    Text("Receving", 
                    style: TextStyle(fontFamily: "Roboto", color: primaryColor, fontSize: 24.0, fontWeight: FontWeight.bold,decoration: TextDecoration.none)),
                  ],
                ),
              ),
            
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("path/0/..", style: TextStyle(fontFamily: "Roboto", color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.normal,decoration: TextDecoration.none),),
                        Text("${(snapshot.data*100).floor()}%", style: TextStyle(fontFamily: "Roboto", color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.normal,decoration: TextDecoration.none),),
                      ],
                    ),
                  ),
                  new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 50,
                    animation: false,
                    lineHeight: 11.0,
                    percent: snapshot.data,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: primaryDark,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(text:"Ok", color: primaryDark ,textColor: Colors.white, callback: (){
                        Navigator.pop(context);
                      }
                    )
                  ],
                ),
              )
            ],
          );
        }
      );
   
  }
}