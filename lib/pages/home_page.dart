import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_android_studio/core/const.dart';
import 'package:flutter_app_android_studio/core/flutter_icons.dart';
import 'package:flutter_app_android_studio/models/shoe_model.dart';
import 'package:flutter_app_android_studio/pages/detail_page.dart';
import 'package:flutter_app_android_studio/widgets/app_clipper.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ShoeModel> shoeList = ShoeModel.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          FlutterIcons.menu,
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    FlutterIcons.search,
                    color: Colors.black26,
                  ),
                  onPressed: null,
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              itemCount: shoeList.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          shoeModel: shoeList[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 230,
                    margin: EdgeInsets.only(right: 16),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: _buildBackground(index, 230.0),
                        ),
                        Positioned(
                          bottom: 130,
                          right: 10,
                          child: Hero(
                            tag: 'hero${shoeList[index].imgPath}',
                            child: Transform.rotate(
                              angle: -math.pi / 7,
                              child: Image(
                                width: 230,
                                image: AssetImage(
                                    'assets/${shoeList[index].imgPath}'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'JUST FOR YOU',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'VIEW ALL',
                  style: TextStyle(color: AppColors.greenColor, fontSize: 12.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          ...shoeList.map(
            (data) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailPage(
                        shoeModel: data,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('assets/${data.imgPath}'),
                        width: 100,
                        height: 60,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.name}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${data.brand}',
                              style: TextStyle(color: Colors.black26),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${data.price.toInt()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.blueColor,
          unselectedItemColor: Colors.black26,
          currentIndex: 1,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.compass), title: Text('data')),
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.list), title: Text('data')),
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.bag), title: Text('data')),
            BottomNavigationBarItem(
                icon: Icon(FlutterIcons.person_outline), title: Text('data')),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(int index, double width) {
    return ClipPath(
      clipper: AppClipper(cornerSize: 25, diagonalHeight: 100),
      child: Container(
        color: shoeList[index].color,
        width: width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Icon(
                      shoeList[index].brand == 'Nike'
                          ? FlutterIcons.nike
                          : FlutterIcons.converse,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 125,
                    child: Text(
                      '${shoeList[index].name}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '${shoeList[index].price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    FlutterIcons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
