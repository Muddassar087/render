import 'dart:math';

class HistoryModel{
  HistoryModel({this.name,this.dateTime, this.type}){}
  String name;
  DateTime dateTime;
  String type;

  void setType(String type){
    this.type = type;}
  void setName(String name){
    this.name = name;
  }
  void setDateTime(DateTime dateTime){
    this.dateTime = dateTime;
  }

  get getName => this.name;
  get getDateTime => "${this.dateTime.day}-${this.dateTime.month}-${this.dateTime.year}";
  get getType => this.type;
}

List<HistoryModel> historyModels  = [
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  new HistoryModel(name: "some movie's random data 1", dateTime: DateTime.now(), type: "Image"),
  new HistoryModel(name: "some movie's random 1", dateTime: DateTime.now(), type: "Video"),
  new HistoryModel(name: "some movie's data 1", dateTime: DateTime.now(), type: "document"),
  
  
];