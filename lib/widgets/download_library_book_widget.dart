import 'package:flutter/material.dart';

class DownloadLibraryBookWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://ebooks-bay.herokuapp.com/api/v1/images/_Cover_Tools_of_Titans.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black54,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.cloud_download_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                Text(
                  'download',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
