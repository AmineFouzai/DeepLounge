import 'package:DeepLounge/auth/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:DeepLounge/auth/User.dart';

class HomeContent extends StatefulWidget {
  final String title, description;
  HomeContent({this.title, this.description});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  Future getDocs() async {
    List<Content> coffes = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("coffes").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.data());
      var data = a.data();
      final ref = FirebaseStorage.instance.ref().child(data['image']);
      var url = await ref.getDownloadURL();
      print(url);
      coffes.add(Content(
          coffeid: a.id,
          width: 100,
          height: 100,
          description: data['description'],
          uri: url));
    }
    return coffes;
  }

  @override
  void initState() {
    super.initState();
    getDocs();
  }

  @override
  Widget build(BuildContext context) {
    var id = AuthService().userData();
    print(id);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 100),
              child: FutureBuilder(
                  future: getDocs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Content> coffes = snapshot.data;

                      return Content(
                        coffeid: coffes[0].coffeid,
                        width: 200,
                        height: 200,
                        description: coffes[0].description,
                        uri: coffes[0].uri,
                      );
                    }
                  })),
          Flexible(
              child: FutureBuilder(
                  future: getDocs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Content> coffes = snapshot.data;
                      return ListView(
                          scrollDirection: Axis.horizontal, children: coffes);
                    }
                  })),
        ],
      ),
    );
  }
}

class Content extends StatefulWidget {
  final double width, height;
  final String description;
  final String uri;
  final String coffeid;
  Content({this.coffeid, this.width, this.height, this.description, this.uri});

  void set width(double width) {
    width = width;
  }

  void set height(double height) {
    height = height;
  }

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  Color _pressedColor = Colors.grey;
  int _preesedTimes = 1;
  String favourite_id = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            widget.uri,
            width: widget.width,
            height: widget.height,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.description == null ? '' : widget.description),
              IconButton(
                  color: _pressedColor,
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    CollectionReference favourites =
                        FirebaseFirestore.instance.collection('favourites');

                    if (_preesedTimes % 2 != 0) {
                      favourites.add({
                        "user_id": AuthService().userData(),
                        "coffe_id": widget.coffeid
                      }).then((value) => setState(() {
                            _preesedTimes = _preesedTimes + 1;
                            _pressedColor = Colors.pink;
                            favourite_id = value.id;
                          }));
                    } else {
                      favourites
                          .doc(favourite_id)
                          .delete()
                          .then((value) => setState(() {
                                _preesedTimes = _preesedTimes + 1;
                                _pressedColor = Colors.grey;
                                favourite_id = "";
                              }));
                    }
                  })
            ],
          ),
        ],
      ),
    );
  }
}
