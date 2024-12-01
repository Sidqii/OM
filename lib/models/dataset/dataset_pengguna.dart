class DatasetPengguna {
  final int id;
  final int id_level;
  final int id_pegawai;
  final String username;
  final String password;

  DatasetPengguna({
    required this.id,
    required this.id_level,
    required this.id_pegawai,
    required this.username,
    required this.password,
  });

  factory DatasetPengguna.fromJson(Map<String, dynamic> json) {
    return DatasetPengguna(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      id_level: json['id_level'] is int
          ? json['id_level']
          : int.parse(json['id_level'].toString()),
      id_pegawai: json['id_pegawai'] is int
          ? json['id_pegawai']
          : int.parse(json['id_pegawai'].toString()),
      username: json['username']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
    );
  }

  static List<DatasetPengguna> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DatasetPengguna.fromJson(json)).toList();
  }
}
