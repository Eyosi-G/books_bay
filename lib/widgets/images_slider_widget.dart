import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImagesSliderWidget extends StatefulWidget {
  @override
  _ImagesSliderWidgetState createState() => _ImagesSliderWidgetState();
}

class _ImagesSliderWidgetState extends State<ImagesSliderWidget> {
  final _quotes = [
    Quote(
      image: 'image_1.jpg',
      quote: "A book is a dream you hold in your hands.",
      index: 0,
    ),
    Quote(
      image: 'image_2.jpg',
      quote: "Take a good book to bed with you—books do not snore.",
      index: 1,
    ),
    Quote(
      image: 'image_3.jpg',
      quote: "Wear the old coat and buy the new book.",
      index: 2,
    ),
  ];

  int _current = 0;
  final _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (detail) {
        if (detail.delta.dx < 0) {
          _controller.nextPage();
        } else {
          _controller.previousPage();
        }
      },
      child: Stack(
        children: [
          CarouselSlider(
            items: _quotes.map((quote) {
              return Stack(
                children: [
                  Image.asset(
                    'assets/images/${quote.image}',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                    ),
                  ),
                  Align(
                    child: Container(
                      child: Text(
                        '${quote.quote}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        left: 10,
                      ),
                      width: 150,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              );
            }).toList(),
            carouselController: _controller,
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _quotes.map((quote) {
                int index = quote.index;
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(255, 255, 255, 1)
                        : Color.fromRGBO(255, 255, 255, 0.4),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Quote {
  final String image;
  final String quote;
  final int index;
  Quote({this.image, this.quote, this.index});
}
