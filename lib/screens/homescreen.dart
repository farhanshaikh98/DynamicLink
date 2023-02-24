import 'package:dynamic_link/screens/product_detail_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  final String? path;
  const HomeScreen({super.key, required this.path});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> bookImgs = [
    "assets/aaron-burden.jpg",
    "assets/brett-jordan.jpg",
    "assets/vika-strawberrika.jpg",
    "assets/ashim-d-silva.jpg",
  ];
  List<String> bookPrice = [
    "\$20.00",
    "\$23.00",
    "\$14.00",
    "\$50.00",
  ];
  List<String> bookNames = [
    "Fahrenheit 451 by Ray Bradbury",
    "1984 by George Orwell",
    "The Lord of the Rings by J.R.R. Tolkien",
    "The Kite Runner by Khaled Hosseini",
  ];
  List<String> bookDescription = [
    "Ray Bradbury’s dystopian world shines a light on Western societies’ dependence on the media. The main character’s job is to find and burn any books he can find – until he begins to question everything. Considering the state of current politics and world affairs, this is one of the absolute must-read books in life.",
    "1984 tells the futuristic story of a dystopian, totalitarian world where free will and love are forbidden. Although the year 1984 has long since passed, the prophecy of a society controlled by fear and lies is arguably more relevant now than ever.",
    "Tolkien’s fantasy epic is one of the top must-read books out there. Set in Middle Earth – a world full of hobbits, elves, orcs, goblins, and wizards – The Lord of the Rings will take you on an unbelievable adventure.",
    "The Kite Runner is a moving story of an unlikely friendship between a wealthy boy and the son of his father’s servant. Set in Afghanistan during a time of tragedy and destruction, this unforgettable novel will have you hooked from start to finish.",
  ];

  openTheBook() {
    if (widget.path != null) {
      int bookNo = -1;
      if (widget.path == '/book0') {
        bookNo = 0;
      } else if (widget.path == '/book1') {
        bookNo = 1;
      } else if (widget.path == '/book2') {
        bookNo = 2;
      } else if (widget.path == '/book3') {
        bookNo = 3;
      } else if (widget.path == '/book4') {
        bookNo = 4;
      } else if (widget.path == '/book5') {
        bookNo = 5;
      }
      print("------------------------------");
      print(bookNo);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                    bookNo: bookNo,
                    discription: bookDescription.elementAt(bookNo),
                    image: bookImgs.elementAt(bookNo),
                    price: bookPrice.elementAt(bookNo),
                    name: bookNames.elementAt(bookNo),
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Book Store',
          style: TextStyle(color: Colors.black),
        ),
        // actions: [
        //   TextButton(
        //       onPressed: () async {
        //         await Share.share(
        //             'Hey, checkout this awesome app https://dynamicproduct.page.link');
        //       },
        //       child: Row(
        //         children: [
        //           Icon(Icons.share),
        //           SizedBox(
        //             width: 5,
        //           ),
        //           Text('Share with Friends'),
        //         ],
        //       ))
        // ],
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          itemCount: bookImgs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                              bookNo: index,
                              discription: bookDescription.elementAt(index),
                              image: bookImgs.elementAt(index),
                              price: bookPrice.elementAt(index),
                              name: bookNames.elementAt(index),
                            )));
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      bookImgs.elementAt(index),
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text((bookPrice[index])),
                          IconButton(
                              onPressed: () async {
                                final dynamicLinkParams = DynamicLinkParameters(
                                  link: Uri.parse(
                                      "https://dynamicproduct.page.link/book${index}}"),
                                  uriPrefix: "https://dynamicproduct.page.link",
                                  androidParameters: AndroidParameters(
                                      packageName: "com.example.dynamic_link",
                                      fallbackUrl: Uri.parse(
                                          'https://dynamicproduct.page.link')),
                                  iosParameters: IOSParameters(
                                      bundleId: "com.example.app.ios",
                                      fallbackUrl:
                                          Uri.parse('https://myiosapp.link')),
                                );

                                final dynamicLink = await FirebaseDynamicLinks
                                    .instance
                                    .buildShortLink(dynamicLinkParams);

                                await Share.share(
                                    dynamicLink.shortUrl.toString());
                              },
                              icon: Icon(Icons.share)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
