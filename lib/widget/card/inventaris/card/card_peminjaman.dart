import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/models/dataset/dataset_peminjamanDetail.dart';
import 'package:pusdatin_end/providers/providers_peminjaman.dart';
import 'package:pusdatin_end/widget/card/inventaris/detail/detail_peminjaman.dart';
import 'package:pusdatin_end/widget/component/page/comp_cardLoad.dart';

class CardPeminjaman extends StatefulWidget {
  final DatasetPeminjamandetail pinjam;

  const CardPeminjaman({Key? key, required this.pinjam}) : super(key: key);

  @override
  _CardPeminjaman createState() => _CardPeminjaman();
}

class _CardPeminjaman extends State<CardPeminjaman> {
  @override
  Widget build(BuildContext context) {
    final boldStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
    final subtitleStyle = TextStyle(color: Colors.grey[600], fontSize: 14);
    final providerPeminjaman = Provider.of<ProvidersPeminjaman>(context);
    
    String formatInv(List<Inventaris> inventaris) {
      return inventaris.map((e) => e.namaInventaris).join(' dan ');
    }

    if (providerPeminjaman.isLoading) {
      return Center(
        child: CardLoad(),
      );
    } else if (providerPeminjaman.errorMessage != null) {
      return Center(
        child: Text('Error: ${providerPeminjaman.errorMessage}'),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => detailPeminjaman(detail: widget.pinjam),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama Penanggung Jawab', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.pinjam.namaPegawai, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Inventaris', style: boldStyle),
                      Text(formatInv(widget.pinjam.inventaris)),
                      SizedBox(height: 6),
                      Text('Nama Peminjam', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.pinjam.namaPeminjam, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Instansi', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.pinjam.instansi, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Tanggal Pengembalian', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.pinjam.tanggalPengembalian,
                          style: subtitleStyle),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     ClipRRect(
                //       borderRadius: BorderRadius.circular(10),
                //       child: Image.network(
                //         widget.pinjam.databarang.foto,
                //         width: 150,
                //         height: 150,
                //         fit: BoxFit.cover,
                //         errorBuilder: (context, error, stackkTrace) {
                //           return Icon(
                //             Icons.broken_image,
                //             size: 150,
                //             color: Colors.red,
                //           );
                //         },
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
      );
    }
  }
}
