class ChapterLocalModel {
  String endpoint;
  int index, id;

  ChapterLocalModel({this.endpoint, this.index, this.id});

  factory ChapterLocalModel.fromDatabase(Map<String,dynamic>json){
    return ChapterLocalModel(
      id: json['id'],
      index: json['index'],
      endpoint: json['endpoint']
    );
  }

  void setEndpoint(String value){
    endpoint = value;
  }
  void setIndex(int value){
    index = value;
  }

  String get getEndpoint => endpoint;

  int get getIndex => index;

  Map<String, dynamic> toDatabase() =>
      {'id': this.id, 'index': this.index, 'endpoint': this.endpoint};
}
