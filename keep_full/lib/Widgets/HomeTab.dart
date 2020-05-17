import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Models/AppKeepFull.dart';
import '../Models/Grocery.dart';

class HomeTab extends StatelessWidget {
  final List<Grocery> groceries;
  final Function openGroceryListTab;

  HomeTab(this.groceries, this.openGroceryListTab);

  /// Generate a list containing random images based on the assets images
  List<String> randomImages() {

    final List<String> images = App.carouselImagesHomeTab();
    images.shuffle();
    int maxImages = 3;
    return images.getRange(0, maxImages ).toList();
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> itemsCarousel;

    itemsCarousel = randomImages()
        .map(
          (item) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0.5,
                ),
              ),
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  item,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        )
        .toList();

    itemsCarousel.insert(
      0,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
        child: GestureDetector(
          onTap: () {
            openGroceryListTab();
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 0.5,
              ),
            ),
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                  child: Text(
                      "You have ${groceries.length} items in your grocery list")),
            ),
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Welcome",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                "Pedro Medeiros",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Center(
            child: Builder(builder: (context) {
              final double height = MediaQuery.of(context).size.height;
              print(height);
              return CarouselSlider(
                options: CarouselOptions(
                  height: height * 0.6,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                ),
                items: itemsCarousel,
              );
            }),
          ),
        )
      ],
    );
  }
}
