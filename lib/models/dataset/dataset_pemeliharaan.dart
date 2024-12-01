class DatasetPemeliharaan {
  final int id;
  final int id_inventaris;
  final int jumlah;
  final int id_pegawai;
  final String foto;
  final String kondisi;
  final String lokasi;
  final String keterangan;
  final String status;
  final DateTime tanggal_pemeliharaan;
  final String catatan;

  DatasetPemeliharaan({
    required this.id,
    required this.id_inventaris,
    required this.jumlah,
    required this.id_pegawai,
    required this.foto,
    required this.kondisi,
    required this.lokasi,
    required this.keterangan,
    required this.status,
    required this.tanggal_pemeliharaan,
    required this.catatan,
  });

  factory DatasetPemeliharaan.fromJson(Map<String, dynamic> json) {
    return DatasetPemeliharaan(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      id_inventaris: json['id_inventaris'] is int
          ? json['id_inventaris']
          : int.parse(json['id_inventaris'].toString()),
      jumlah: json['jumlah'] is int
          ? json['jumlah']
          : int.parse(json['jumlah'].toString()),
      id_pegawai: json['id_pegawai'] is int
          ? json['id_pegawai']
          : int.parse(json['id_pegawai'].toString()),
      foto: json['foto']?.toString() ?? '',
      kondisi: json['kondisi']?.toString() ?? '',
      lokasi: json['lokasi']?.toString() ?? '',
      keterangan: json['keterangan']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      tanggal_pemeliharaan: json['tanggal_pemeliharaan'] is String
          ? DateTime.parse(json['tanggal_pemeliharaan'].toString())
          : DateTime.fromMillisecondsSinceEpoch(
              json['tanggal_pemeliharaan'] ?? 0),
      catatan: json['catatan']?.toString() ?? '',
    );
  }

  static List<DatasetPemeliharaan> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DatasetPemeliharaan.fromJson(json)).toList();
  }
}
