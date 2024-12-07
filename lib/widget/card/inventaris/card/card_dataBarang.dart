import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/providers/providers_dataBarang.dart';
import 'package:pusdatin_end/widget/card/inventaris/detail/detail_dataBarang.dart';
import 'package:pusdatin_end/widget/component/page/comp_cardLoad.dart';
import 'package:pusdatin_end/models/dataset/dataset_databarang.dart';

class DataBarangCard extends StatefulWidget {
  final DatasetDatabarang item;
  const DataBarangCard({Key? key, required this.item}) : super(key: key);

  @override
  _DataCardState createState() => _DataCardState();
}

class _DataCardState extends State<DataBarangCard> {
  // Fungsi untuk navigasi ke halaman detail
  void navigateToDetailPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detailDatabarang(
          item: widget.item,
        ), // Pastikan 'DetailPage' adalah halaman yang sesuai
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final boldStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
    final subtitleStyle = TextStyle(color: Colors.grey[600], fontSize: 14);

    final provider = Provider.of<ProviderDatabarang>(context);

    if (provider.isLoading) {
      return Center(
        child: CardLoad(),
      );
    } else if (provider.errorMessage != null) {
      return Center(
        child: Text('Error: ${provider.errorMessage}'),
      );
    } else {
      return GestureDetector(
        onTap: () =>
            navigateToDetailPage(context), // Navigasi ketika card ditekan
        child: Card(
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
                      Text('No. Seri Barang', style: boldStyle),
                      SizedBox(height: 2),
                      Text('${widget.item.id}', style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Merk Barang', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.item.merk, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Status Barang', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.item.status, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Kondisi', style: boldStyle),
                      SizedBox(height: 2),
                      Text(widget.item.kondisi, style: subtitleStyle),
                      SizedBox(height: 6),
                      Text('Jumlah Barang', style: boldStyle),
                      SizedBox(height: 2),
                      Text('${widget.item.jumlah}', style: subtitleStyle),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('Gambar ditekan');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.item.foto,
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 150,
                              color: Colors.red,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
