import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  String? name, position, phone, email, image;
  DetailsScreen({this.name, this.position, this.email, this.phone, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name.toString())),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 130, horizontal: 20),
        child: Card(
          child: Container(
            //height: 350,
            //width: 500,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(image.toString()),
                  radius: 80,
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(name.toString(), style: TextStyle(fontSize: 25)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(position.toString(), style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone),
                          FlatButton(
                              onPressed: () {
                                launch('tel:$phone');
                              },
                              child: Text(
                                phone.toString(),
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email),
                          FlatButton(
                            onPressed: () {
                              launch('mailto:$email');
                            },
                            child: Text(email.toString(),
                                style: TextStyle(fontSize: 18)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white70,
    );
  }
}
