import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  Favourite({Key key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<String> _favourites = ['favourite1', 'favourite2', 'favourite3'];

  Widget _buildFavouritetItem(BuildContext context) {
    return new ListView.builder(
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
              if (direction == DismissDirection.startToEnd) {
                setState(() {
                  _favourites.removeAt(index);
                });
              } else {
                setState(() {
                  _favourites.removeAt(index);
                });
              }
            },
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                leading: Image.asset("images/coffe2.png"),
                title: Text(_favourites[index]),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildFavouritetItem(context),
    );
  }
}
