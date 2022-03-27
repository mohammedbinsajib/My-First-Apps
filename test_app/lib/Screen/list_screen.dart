import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Screen/details_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Screen')),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('info').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            print(snapshot.data!.docs.length);
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.separated(
                  itemBuilder: (__, int index) {
                    Map<String, dynamic> docData =
                        snapshot.data!.docs[index].data();
                    if (docData.isEmpty) {
                      return Text('Document is Empty');
                    }

                    String name =
                        snapshot.data!.docs.elementAt(index).get('name');
                    String position =
                        snapshot.data!.docs.elementAt(index).get('position');
                    String phone =
                        snapshot.data!.docs.elementAt(index).get('phone');
                    String email =
                        snapshot.data!.docs.elementAt(index).get('email');

                    return Container(
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              title: Text(name),
                              subtitle: Text(position),
                              leading: Image.network(
                                snapshot.data!.docs
                                    .elementAt(index)
                                    .get('image'),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                              name: name,
                                              position: position,
                                              phone: phone,
                                              email: email,
                                              image: snapshot.data!.docs
                                                  .elementAt(index)
                                                  .get('image'),
                                            )));
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (__, ___) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.docs.length);
            } else {
              return const Center(
                child: Text('Documents  Unavailable'),
              );
            }
          } else {
            return const Center(
              child: Text('Getting Error'),
            );
          }
        },
      )),
      backgroundColor: Colors.indigo.shade900,
    );
  }
}
