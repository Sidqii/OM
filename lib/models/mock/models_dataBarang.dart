class dataBarang {
  String idBarang;    // ID Barang
  String nmBarang;    // Nama Barang
  String mrkBarang;   // Merek Barang
  String pngBarang;   // Pengadaan Barang
  int lssBarang;      // Lisensi Barang
  DateTime tglMasuk;  // Tanggal Masuk Barang
  int jmlBarang;      // Jumlah Barang
  String kondisi;     // Kondisi Barang
  String imgBarang;   // Image Barang

  dataBarang({
    required this.idBarang,
    required this.nmBarang,
    required this.mrkBarang,
    required this.pngBarang,
    required this.lssBarang,
    required this.tglMasuk,
    required this.jmlBarang,
    required this.kondisi,
    required this.imgBarang,
  });
}