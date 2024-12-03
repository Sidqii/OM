import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/providers/providers_pemeliharaan.dart';
import 'package:pusdatin_end/widget/card/inventaris/detail/detail_pemeliharaan.dart';
import 'package:pusdatin_end/widget/component/comp_cardLoad.dart';

class CardPemeliharaan extends StatefulWidget {
  final Pemeliharaan pelihara;

  const CardPemeliharaan({Key? key, required this.pelihara}) : super(key: key);

  @override
  _CardPemeliharaan createState() => _CardPemeliharaan();
}

class _CardPemeliharaan extends State<CardPemeliharaan> {

  String formatDate(String date) {
    try {
      DateTime parseDate = DateTime.parse(date);
      return DateFormat('yyyy - MM - dd').format(parseDate);
    } catch (e) {
      return date;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final boldStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
    final subtitleStyle = TextStyle(color: Colors.grey[600], fontSize: 14);
    final providerPelihara = Provider.of<ProviderPemeliharaan>(context);

    if (providerPelihara.isLoading) {
      return Center(
        child: CardLoad(),
      );
    } else if (providerPelihara.errorMessage != null) {
      return Center(
        child: Text('Error: ${providerPelihara.errorMessage}'),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => detailPemeliharaan(
                item: widget.pelihara.barang,
                pegawai: widget.pelihara.pegawai,
                pelihara: widget.pelihara.pemeliharaan,
              ),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      Text('Nama Petugas', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.pelihara.pegawai.nama, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Inventaris', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.pelihara.barang.nama, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Kondisi Barang', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.pelihara.pemeliharaan.kondisi, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Status', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.pelihara.pemeliharaan.status, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Tanggal Pemeliharaan', style: boldStyle),
                      SizedBox(height: 2),
                      Text(formatDate('${widget.pelihara.pemeliharaan.tanggal_pemeliharaan}'), style: subtitleStyle),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
              ],
            ),
          ),
        ),
      );
    }
  }
}
