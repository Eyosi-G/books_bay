import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final commentStyle = TextStyle(
    color: Colors.black38,
    fontSize: 15,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            title: Text(
              'Abebe',
            ),
            subtitle: Text(
              'Dec 12, 2020',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            trailing: PopupMenuButton(
              onSelected: (val) {},
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text('delete'),
                    value: 0,
                  ),
                ];
              },
            ),
          ),
          Text(
            'A very nice novel. I enjoyed every line of it.A very nice novel. I enjoyed every line of it.A very nice novel. I enjoyed every line of it.',
            style: commentStyle,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
//Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: [
//Text(
//'Abebe',
//style: nameStyle,
//),
//Text(
//'A very nice novel. I enjoyed every line of it.',
//style: commentStyle,
//)
//],
//);

//ListTile(
//title: Text('Abebe'),
//subtitle: Text(
//'A very nice novel. I enjoyed every line of it.A very nice novel. I enjoyed every line of it.A very nice novel. I enjoyed every line of it.'),
//trailing: PopupMenuButton(
//onSelected: (val) {},
//itemBuilder: (ctx) {
//return [
//PopupMenuItem(
//child: Text('delete'),
//value: 0,
//),
//];
//},
//),
//);
