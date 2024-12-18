class DatasetPeminjamandetail {
  String namaPeminjam;
  String namaPegawai;
  String instansi;
  String hal;
  String tanggalPengembalian;
  String tanggalPeminjaman;
  String status;
  List<Inventaris> inventaris;

  DatasetPeminjamandetail({
    required this.namaPeminjam,
    required this.namaPegawai,
    required this.instansi,
    required this.hal,
    required this.tanggalPengembalian,
    required this.tanggalPeminjaman,
    required this.status,
    required this.inventaris,
  });

  factory DatasetPeminjamandetail.fromJson(Map<String, dynamic> json) {
    var list = json['inventaris'] as List;
    List<Inventaris> inventarisList =
        list.map((i) => Inventaris.fromJson(i)).toList();

    return DatasetPeminjamandetail(
      namaPeminjam: json['nama_peminjam'] ?? 'Tidak ada nama',
      namaPegawai: json['nama_pegawai'] ?? 'Tidak ada nama',
      instansi: json['instansi'] ?? 'Tidak ada instansi',
      hal: json['hal'] ?? 'Tidak ada hal',
      tanggalPengembalian: json['tanggal_pengembalian'] ?? ' - ',
      tanggalPeminjaman: json['tanggal_peminjaman']??' - ',
      status: json['status'] ?? ' - ',
      inventaris: inventarisList,
    );
  }

  //merubah format data menjadi Json
  Map<String, dynamic> toJson() {
    return {
      'nama_peminjam': namaPeminjam,
      'nama_pegawai': namaPegawai,
      'instansi': instansi,
      'hal': hal,
      'tanggal_pengembalian': tanggalPengembalian,
      'tanggal_peminjaman' : tanggalPeminjaman,
      'status': status,
      'inventaris': inventaris.map((item) => item.toJson()).toList(),
    };
  }
}

class Inventaris {
  String namaInventaris;
  String kondisi;
  String foto;

  Inventaris({
    required this.namaInventaris,
    required this.kondisi,
    required this.foto,
  });

  factory Inventaris.fromJson(Map<String, dynamic> json) {
    return Inventaris(
      namaInventaris: json['nama_inventaris'] ?? 'Tidak ada nama inventaris',
      kondisi: json['kondisi'] ?? 'Tidak ada kondisi',
      foto: json['foto'] ?? 'Tidak ada foto',
    );
  }

  //merubah format data menjadi Json
  Map<String, dynamic> toJson() {
    return {
      'nama_inventaris': namaInventaris,
      'kondisi': kondisi,
      'foto': foto,
    };
  }
}
