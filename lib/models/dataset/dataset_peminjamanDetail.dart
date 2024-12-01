class DatasetPeminjamandetail {
  final String namaPeminjam;
  final String namaPegawai;
  final String instansi;
  final String hal;
  final String tanggalPengembalian;
  final List<Inventaris> inventaris;

  DatasetPeminjamandetail({
    required this.namaPeminjam,
    required this.namaPegawai,
    required this.instansi,
    required this.hal,
    required this.tanggalPengembalian,
    required this.inventaris,
  });

  factory DatasetPeminjamandetail.fromJson(Map<String, dynamic> json) {
    var list = json['inventaris'] as List;
    List<Inventaris> inventarisList = list.map((i) => Inventaris.fromJson(i)).toList();

    return DatasetPeminjamandetail(
      namaPeminjam: json['nama_peminjam'] ?? 'Tidak ada nama',
      namaPegawai: json['nama_pegawai'] ?? 'Tidak ada nama',
      instansi: json['instansi'] ?? 'Tidak ada instansi',
      hal: json['hal'] ?? 'Tidak ada hal',
      tanggalPengembalian: json['tanggal_pengembalian'] ?? 'Tanggal belum ditentukan',
      inventaris: inventarisList,
    );
  }
}

class Inventaris {
  final String namaInventaris;
  final String kondisi;

  Inventaris({
    required this.namaInventaris,
    required this.kondisi,
  });

  factory Inventaris.fromJson(Map<String, dynamic> json) {
    return Inventaris(
      namaInventaris: json['nama_inventaris'] ?? 'Tidak ada nama inventaris',
      kondisi: json['kondisi'] ?? 'Tidak ada kondisi',
    );
  }
}
