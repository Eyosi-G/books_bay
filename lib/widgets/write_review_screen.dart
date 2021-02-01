import 'package:flutter/material.dart';

class WriteReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final focusBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black38,
      ),
    );
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Container(
          height: height * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      print('here');
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.black12,
                ),
              ),
              Expanded(child: Container()),
              Align(
                child: Text(
                  'Write a review',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                minLines: 6,
                decoration: InputDecoration(
                  border: focusBorder,
                  fillColor: Color(0xfff6f6f6),
                  filled: true,
                  focusColor: Colors.black,
                  focusedBorder: focusBorder,
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  OutlineButton(
                    onPressed: () {},
                    child: Text('Cancel'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
