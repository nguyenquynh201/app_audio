import 'dart:convert';

import 'package:ebook_audio/constant/assets_image/asset_image.dart';
import 'package:ebook_audio/constant/ui_color.dart';
import 'package:ebook_audio/screen/default_audio_page.dart';
import 'package:ebook_audio/widget/app_tab.dart';
import 'package:ebook_audio/widget/item_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List? popular;
  List? product;
  late TabController _tabController;
  ScrollController? _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadData();
    ReadDataProduct();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
  }

  ReadDataProduct() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/books.json')
        .then((value) {
      setState(() {
        product = json.decode(value);
      });
    });
  }

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/popular.json')
        .then((value) {
      setState(() {
        popular = json.decode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UIColors.background,
      body: SafeArea(
        minimum:
            EdgeInsets.only(right: size.width * 0.03, left: size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.width * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ImageIcon(AssetImage(AssetImages.menu),
                    size: 24, color: Colors.black),
                Row(
                  children: [
                    Icon(Icons.search, color: Colors.black),
                    Icon(Icons.notifications_active, color: Colors.black),
                  ],
                )
              ],
            ),
            SizedBox(height: size.width * 0.03),
            Container(
              child: Text(
                'Popular Books',
                style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: size.width * 0.02),
            Container(
                height: size.height / 6,
                child: PageView.builder(
                    itemCount: popular == null ? 0 : popular!.length,
                    controller: PageController(viewportFraction: 0.8),
                    itemBuilder: (context, index) {
                      return Container(
                        height: size.height / 6,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(popular![index]['img']),
                                fit: BoxFit.cover)),
                      );
                    })),
            Expanded(
                child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool isScroll) {
                return [
                  SliverAppBar(
                      backgroundColor: UIColors.background,
                      pinned: true,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.all(0),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: Offset(0, 0))
                                ]),
                            tabs: [
                              AppTabWidget(
                                  size: size,
                                  text: 'New',
                                  color: UIColors.menu1Color),
                              AppTabWidget(
                                  size: size,
                                  text: 'Popular',
                                  color: UIColors.menu2Color),
                              AppTabWidget(
                                  size: size,
                                  text: 'Trending',
                                  color: UIColors.menu3Color),
                            ],
                          ),
                        ),
                      ))
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: product == null ? 0 : product!.length,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (context, index) {
                      return ItemProductWidget(
                        size: size,
                        listProduct: product!,
                        index: index,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DefaultAudioPageScreen(
                                      booksData: product!, index: index)));
                        },
                      );
                    },
                  ),
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text('Content'),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text('Content'),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
