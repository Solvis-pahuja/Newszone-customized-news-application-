import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newszonecollege/view/HomeScreen.dart';

class MyNewsPage extends StatefulWidget {
  const MyNewsPage({super.key});

  @override
  State<MyNewsPage> createState() => _MyNewsPageState();
}

class _MyNewsPageState extends State<MyNewsPage> {
  late String imageUrl;
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    imageUrl = '';
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final ref = storage.ref().child('pmnews.webp');

    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Latest News'),
          leading: BackButton(
            onPressed: () {
              Get.to(HomeScreen());
            },
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("mynews").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(itemCount: 1,itemBuilder: (context,index){
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () => null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                children: [
                                  Stack(children: [
                                    Image(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: Card(
                                        elevation: 0,
                                        color:
                                        Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: Text("${snapshot.data!.docs[index]["title"]}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  Divider(),
                                  Text("${snapshot.data!.docs[index]["subtitle"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error.toString()}"),
                );
              }
            } else {
              return CircularProgressIndicator();
            }
            return Text('');
          },
        ));
  }
}
