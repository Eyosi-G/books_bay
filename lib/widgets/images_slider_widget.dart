import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImagesSliderWidget extends StatefulWidget {
  @override
  _ImagesSliderWidgetState createState() => _ImagesSliderWidgetState();
}

class _ImagesSliderWidgetState extends State<ImagesSliderWidget> {
  final _imagesList = [
    'image_1.jpg',
    'image_2.jpg',
    'image_3.jpg',
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
            items: _imagesList
                .map(
                  (image) => Image.asset(
                    'assets/images/$image',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                )
                .toList(),
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
          Positioned.fill(
            child: Container(
              color: Colors.black26,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _imagesList.map((url) {
                int index = _imagesList.indexOf(url);
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
