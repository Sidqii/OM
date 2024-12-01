class DatasetPeminjaman {
  final int id;
  final int id_pegawai;
  final String nama_peminjam;
  final String pangkat_peminjam;
  final String nrp_peminjam;
  final String instasi;
  final String jabatan;
  final String hal;
  final String dokumen_peminjam;
  final String status;
  final DateTime tanggal_peminjam;
  final String catatan;

  DatasetPeminjaman({
    required this.id,
    required this.id_pegawai,
    required this.nama_peminjam,
    required this.pangkat_peminjam,
    required this.nrp_peminjam,
    required this.instasi,
    required this.jabatan,
    required this.hal,
    required this.dokumen_peminjam,
    required this.status,
    required this.tanggal_peminjam,
    required this.catatan,
  });

  factory DatasetPeminjaman.fromJson(Map<String, dynamic> json) {
    return DatasetPeminjaman(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      id_pegawai: json['id_pegawai'] is int
          ? json['id_pegawai']
          : int.parse(json['id_pegawai'].toString()),
      nama_peminjam: json['nama_peminjam']?.toString() ?? '',
      pangkat_peminjam: json['pangkat_peminjam']?.toString() ?? '',
      nrp_peminjam: json['nrp_peminjam']?.toString() ?? '',
      instasi: json['instasi']?.toString() ?? ' - ',
      jabatan: json['jabatan']?.toString() ?? '',
      hal: json['hal']?.toString() ?? '',
      dokumen_peminjam: json['dokumen_peminjam']?.toString() ?? '',
      status: json['dokumen_peminjam']?.toString() ?? '',
      tanggal_peminjam: json['tanggal_peminjam'] is String
          ? DateTime.parse(json['tanggal_peminjam'].toString())
          : DateTime.fromMillisecondsSinceEpoch(json['tanggal_peminjam'] ?? 0),
      catatan: json['catatan']?.toString() ?? '',
    );
  }

  static List<DatasetPeminjaman> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DatasetPeminjaman.fromJson(json)).toList();
  }
}
