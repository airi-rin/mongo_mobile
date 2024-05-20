class LabelModel {
  int? labelId;
  String? labelName;
  String? description;

  LabelModel({this.labelId, this.labelName, this.description});

  Map<String, dynamic> toJson() =>
      {'labelId': labelId, 'labelName': labelName, 'description': description};

  static LabelModel fromJson(Map<String, dynamic> json) => LabelModel(
      labelId: json['labelId'],
      labelName: json['labelName'],
      description: json['description']);
}
