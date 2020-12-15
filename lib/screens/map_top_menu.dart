import 'package:flutter/material.dart';

var allIcons = ['toilets', 'medical'];

class MapTopMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height * .3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (var i = 0; i < 2; i++)
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: OutlineButton(
                      padding: const EdgeInsets.all(3),
                      child: Image.asset(
                        'assets/images/' + allIcons[i] + '.png',
                        width: MediaQuery.of(context).size.width / 5,
                      ),
                      splashColor: Colors.white,
                      highlightedBorderColor: Colors.teal,
                      onPressed: () {
                        Navigator.of(context).pop(allIcons[i]);
                      },
                    ),
                  )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
