class DatasetPegawai {
  final int id;
  final String nama;
  final String email;
  final String telegram_id;
  final String pangkat;
  final String nrp;
  final String jabatan;
  final String foto;

  DatasetPegawai({
    required this.id,
    required this.nama,
    required this.email,
    required this.telegram_id,
    required this.pangkat,
    required this.nrp,
    required this.jabatan,
    required this.foto,
  });

  factory DatasetPegawai.fromJson(Map<String, dynamic> json) {
    return DatasetPegawai(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      nama: json['nama']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      telegram_id: json['telegram_id']?.toString() ?? '',
      pangkat: json['pangkat']?.toString() ?? '',
      nrp: json['nrp']?.toString() ?? '',
      jabatan: json['jabatan']?.toString() ?? '',
      foto: json['foto']?.toString()??'',
    );
  }

  static List<DatasetPegawai> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DatasetPegawai.fromJson(json)).toList();
  }
}
