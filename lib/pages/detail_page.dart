import 'package:flutter/material.dart';
import 'package:flutter_app_android_studio/core/const.dart';
import 'package:flutter_app_android_studio/core/flutter_icons.dart';
import 'package:flutter_app_android_studio/models/shoe_model.dart';
import 'package:flutter_app_android_studio/widgets/app_clipper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:math' as math;

class DetailPage extends StatefulWidget {
  final ShoeModel shoeModel;

  const DetailPage({Key key, this.shoeModel}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.shoeModel.color,
      appBar: AppBar(
        backgroundColor: widget.shoeModel.color,
        elevation: 0,
        title: Text('CATEGORIES'),
        leading: IconButton(
          icon: Icon(FlutterIcons.left_open_1),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                child: ClipPath(
                  clipper: AppClipper(
                      cornerSize: 50,
                      diagonalHeight: 180,
                      roundedBottom: false),
                  child: Container(
                    padding: EdgeInsets.only(top: 180, left: 16, right: 16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          child: Text(
                            '${widget.shoeModel.name}',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        _buildRating(),
                        SizedBox(height: 24.0),
                        Text(
                          'DETAILS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          '${widget.shoeModel.desc}',
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          'COLOR OPTIONS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            _buildColorOptions(AppColors.blueColor),
                            _buildColorOptions(AppColors.greenColor),
                            _buildColorOptions(AppColors.orangeColor),
                            _buildColorOptions(AppColors.redColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: _buildBottom(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Hero(
                tag: 'hero${widget.shoeModel.imgPath}',
                child: Transform.rotate(
                  angle: -math.pi / 7,
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.9,
                    image: AssetImage('assets/${widget.shoeModel.imgPath}'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 32,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PRICE',
                style: TextStyle(color: Colors.black26),
              ),
              Text(
                '\$${widget.shoeModel.price.toInt()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 50,
            ),
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Text(
              'ADD CART',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOptions(Color color) {
    return Container(
      height: 20,
      width: 20,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        SizedBox(width: 16),
        Text(
          '134 Reviews',
          style: TextStyle(color: Colors.black26),
        ),
      ],
    );
  }
}
