class DatasetLevel {
  final int id;
  final String level;

  DatasetLevel({
    required this.id,
    required this.level
  });

  factory DatasetLevel.fromJson(Map<String, dynamic>json){
    return DatasetLevel(
      id: json['id'] is int? json['id'] : int.parse(json['id']),
      level: json['level']?.toString()??'',
      );
  }

  static List<DatasetLevel> fromJsonList(List<dynamic>jsonList){
    return jsonList.map((json) => DatasetLevel.fromJson(json)).toList();
  }
}