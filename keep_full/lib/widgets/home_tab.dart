import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_full/Blocs/blocs.dart';
import '../Widgets/widgets.dart';
import '../Models/models.dart';

class HomeTab extends StatefulWidget {
  final Function openGroceryListTab;


  HomeTab(this.openGroceryListTab);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  /// Generate a list containing random images based on the assets images
  List<String> randomImages() {

    final List<String> images = App.carouselImagesHomeTab();
    images.shuffle();
    int maxImages = 3;
    return images.getRange(0, maxImages ).toList();
  }

  /// Navigates to FoodCuriosities page
  void openFoodCuriosities(BuildContext ctx, String image){
    Navigator.of(ctx).push(MaterialPageRoute(
        builder: (bCtx) =>
            FoodCuriosities(initialImage: image,)));

  }



  @override
  Widget build(BuildContext context) {
    List<Widget> itemsCarousel;
    User user = BlocProvider.of<AuthenticationBloc>(context).user;

    itemsCarousel = randomImages()
      .map(
        (item) => Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: (){ openFoodCuriosities(context, item);},
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
        ),
      )
      .toList();

    /// Inserting first card on carousel
    itemsCarousel.insert(
      0,
      
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
        child: GestureDetector(
          onTap: () {
            widget.openGroceryListTab();
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
                child: BlocBuilder<GroceryListBloc, GroceryListState>(
                  builder: (_, state) {
                    return Text(
                        "You have ${BlocProvider.of<GroceryListBloc>(context).groceryList.items.length} items in your grocery list");
                  },

                ),
              ),
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
                "${user.toString()}",
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
