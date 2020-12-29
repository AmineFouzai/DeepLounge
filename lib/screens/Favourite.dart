import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:DeepLounge/auth/UserService.dart';

class Favourite extends StatefulWidget {
  Favourite({Key key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  Future getDocs() async {
    List favourites = [];
    QuerySnapshot favouritesSnapshot =
        await FirebaseFirestore.instance.collection("favourites").get();
    QuerySnapshot coffesSnapshot =
        await FirebaseFirestore.instance.collection("coffes").get();
    for (int i = 0; i < favouritesSnapshot.docs.length; i++) {
      var favourite = favouritesSnapshot.docs[i];
      var favouriteData = favourite.data();
      for (int i = 0; i < coffesSnapshot.docs.length; i++) {
        var coffe = coffesSnapshot.docs[i];
        String userId = AuthService().userData();
        print(userId);
        if (userId == favouriteData['user_id'] &&
            coffe.id == favouriteData['coffe_id']) {
          print(coffe.data());
          var data = coffe.data();
          final ref = FirebaseStorage.instance.ref().child(data['image']);
          var url = await ref.getDownloadURL();
          print(url);
          favourites.add({"fav_id": favourite.id, "url": url, ...coffe.data()});
        }
      }
    }
    return favourites;
  }

  @override
  void initState() {
    super.initState();
  }

//
  Widget _buildFavouritetItem(BuildContext context) {
    return new FutureBuilder(
        future: getDocs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List _favourites = snapshot.data;
            return ListView.builder(
              itemBuilder: (key, index) {
                if (index < _favourites.length) {
                  return Dismissible(
                    key: Key('item ${_favourites[index]}'),
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                            Text('Remove from Favourite',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                            Text('Remove from Favourite',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete Confirmation"),
                            content: const Text(
                                "Are you sure you want to delete this item?"),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text("Delete")),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (DismissDirection direction) {
                      CollectionReference favourites =
                          FirebaseFirestore.instance.collection('favourites');
                      if (direction == DismissDirection.startToEnd) {
                        favourites
                            .doc(_favourites[index]['fav_id'])
                            .delete()
                            .then((value) => setState(() {
                                  _favourites.removeAt(index);
                                }));
                      } else {
                        favourites
                            .doc(_favourites[index]['fav_id'])
                            .delete()
                            .then((value) => setState(() {
                                  _favourites.removeAt(index);
                                }));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: ListTile(
                        leading: Image.network(_favourites[index]['url']),
                        title: Text(_favourites[index]['description']),
                        subtitle: Text("added to favourite"),
                        onTap: () {
                          print("pressed");
                        },
                      ),
                    ),
                  );
                }
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildFavouritetItem(context),
    );
  }
}
