import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailScreen extends StatefulWidget {
  final int bookNo;
  final String image;
  final String name;
  final String discription;
  final String price;
  const ProductDetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.discription,
    required this.price,
    required this.bookNo,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Book details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 250,
              width: double.maxFinite,
              child: Image.asset(
                widget.image,
                fit: BoxFit.fitWidth,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.discription,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Buy ${widget.price}')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () async {
              final dynamicLinkParams = DynamicLinkParameters(
                link: Uri.parse(
                    "https://dynamicproduct.page.link${widget.bookNo}"),
                uriPrefix: "https://dynamicproduct.page.link",
                androidParameters: AndroidParameters(
                    packageName: "com.example.dynamic_link",
                    fallbackUrl: Uri.parse('https://dynamicproduct.page.link')),
                iosParameters: IOSParameters(
                    bundleId: "com.example.app.ios",
                    fallbackUrl: Uri.parse('https://myiosapp.link')),
              );

              final dynamicLink = await FirebaseDynamicLinks.instance
                  .buildShortLink(dynamicLinkParams);

              await Share.share(dynamicLink.shortUrl.toString());
            },
            child: Text('Share With Friends'),
          ),
        ],
      ),
    );
  }
}
