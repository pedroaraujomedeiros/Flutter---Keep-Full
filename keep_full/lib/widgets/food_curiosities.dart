import '../Models/app_keep_full.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FoodCuriosities extends StatefulWidget {
  final String initialImage;

  FoodCuriosities({this.initialImage});

  @override
  _FoodCuriositiesState createState() => _FoodCuriositiesState();
}

class _FoodCuriositiesState extends State<FoodCuriosities> {
  CarouselController _carouselController;
  final List<String> _images =  App.carouselImagesHomeTab();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    if(this.widget.initialImage != null){
      _currentPage = _images.indexOf(this.widget.initialImage);
    }
  }

  @override
  Widget build(BuildContext context) {


    List<Widget> itemsCarousel;
    itemsCarousel =
        _images.map(
          (item) => Card(

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
        ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Curiosities ${_currentPage + 1}/${_images.length}"),
        centerTitle: true,
      ) ,
      body: Container(
        height: double.infinity,
        child: CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            viewportFraction: 1,
            height: double.infinity,
            enableInfiniteScroll: false,
            initialPage: _currentPage,
            onPageChanged: (int page, CarouselPageChangedReason reason){
              setState(() {
                _currentPage = page;
              });
            }
          ),
          items: itemsCarousel,
        ),
      ),
    );
  }
}
