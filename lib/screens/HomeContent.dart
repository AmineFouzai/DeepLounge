import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeContent extends StatefulWidget {
  final String title, description;
  HomeContent({this.title, this.description});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Content(
            width: 200,
            height: 200,
            description: 'some text',
          ),
          Flexible(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Content(width: 100, height: 100, description: null),
                Content(width: 100, height: 100, description: null),
                Content(width: 100, height: 100, description: null),
                Content(width: 100, height: 100, description: null),
                Content(width: 100, height: 100, description: null),
                Content(width: 100, height: 100, description: null)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Content extends StatefulWidget {
  final double width, height;
  final String description;
  Content({this.width, this.height, this.description});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  Color _pressedColor = Colors.grey;
  int _preesedTimes = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/coffe2.png",
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
                    setState(() {
                      if (_preesedTimes % 2 != 0) {
                        _preesedTimes = _preesedTimes + 1;
                        _pressedColor = Colors.pink;
                      } else {
                        _preesedTimes = _preesedTimes + 1;
                        _pressedColor = Colors.grey;
                      }
                    });
                  })
            ],
          ),
        ],
      ),
    );
  }
}
