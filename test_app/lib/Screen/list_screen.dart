import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
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

                    return ListTile(
                      title: Text(name),
                      subtitle: Text(position),
                    );
                  },
                  separatorBuilder: (__, ___) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.docs.length);
            } else {
              return const Center(
                child: Text('Documents aren`t available'),
              );
            }
          } else {
            return const Center(
              child: Text('Getting Error'),
            );
          }
        },
      )),
    );
  }
}
