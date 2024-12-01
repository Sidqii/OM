class DatasetDatabarang {
  final int id;
  final String nama;
  final String kondisi;
  final String status;
  final String merk;
  final String no_seri;
  final int jumlah;
  final String pengadaan;
  final DateTime tanggal_masuk;
  final int? lisensi;
  final String lokasi;
  final String foto;
  final String keterangan;

  DatasetDatabarang({
    required this.id,
    required this.nama,
    required this.kondisi,
    required this.status,
    required this.merk,
    required this.no_seri,
    required this.jumlah,
    required this.pengadaan,
    required this.tanggal_masuk,
    required this.lisensi,
    required this.lokasi,
    required this.foto,
    required this.keterangan,
  });

  factory DatasetDatabarang.fromJson(Map<String, dynamic> json) {
    return DatasetDatabarang(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      nama: json['nama']?.toString() ?? '',
      kondisi: json['kondisi']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      merk: json['merk']?.toString() ?? '',
      no_seri: json['no_seri']?.toString() ?? '',
      jumlah: json['jumlah'] is int
          ? json['jumlah']
          : int.parse(json['jumlah'].toString()),
      pengadaan: json['pengadaan']?.toString() ?? '',
      tanggal_masuk: json['tanggal_masuk'] is String
          ? DateTime.parse(json['tanggal_masuk'].toString())
          : DateTime.fromMillisecondsSinceEpoch(json['tanggal_masuk']??0),
      lisensi: json['lisensi'] != null
          ? (json['lisensi'] is int
              ? json['lisensi']
              : int.parse(json['lisensi'].toString()))
          : null,
      lokasi: json['lokasi']?.toString() ?? '',
      foto: json['foto']?.toString() ?? '',
      keterangan: json['keterangan']?.toString() ?? '',
    );
  }

  static List<DatasetDatabarang> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DatasetDatabarang.fromJson(json)).toList();
  }
}
