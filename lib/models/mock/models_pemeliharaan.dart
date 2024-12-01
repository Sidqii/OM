class Pelihara {
  String nrp;             // nrp Penanggung Jawab
  String nmPJ;            // Nama Penanggung Jawab
  String sttsPelihara;    // Status Pemeliharaan
  String ketPelihara;     // Keterangan Pemeliharaan
  DateTime tglPelihara;   // Tanggal Pemeliharaan
  String imgPJ;           // Image Penanggung jawab

  Pelihara({
    required this.nrp,
    required this.nmPJ,
    required this.sttsPelihara,
    required this.ketPelihara,
    required this.tglPelihara,
    required this.imgPJ,
  });
}