import 'package:flutter/material.dart';
import 'package:card_loading/card_loading.dart';

class CardLoadingWidget extends StatelessWidget {
  final double height;
  final double? width;
  final BorderRadius borderRadius;
  final EdgeInsets margin;

  const CardLoadingWidget({
    Key? key,
    required this.height,
    this.width,
    required this.borderRadius,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardLoading(
      height: height,
      width: width,
      borderRadius: borderRadius,
      margin: margin,
    );
  }
}

class CardLoad extends StatelessWidget {
  const CardLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // CardLoadingWidget(
                        //   height: 30,
                        //   borderRadius: BorderRadius.all(Radius.circular(10)),
                        //   width: 100,
                        //   margin: EdgeInsets.only(bottom: 10),
                        // ),
                        CardLoadingWidget(
                          height: 250,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        // CardLoadingWidget(
                        //   height: 45,
                        //   width: 200,
                        //   borderRadius: BorderRadius.all(Radius.circular(10)),
                        //   margin: EdgeInsets.only(bottom: 10),
                        // ),
                      ],
                    ),
                  );
                },
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
