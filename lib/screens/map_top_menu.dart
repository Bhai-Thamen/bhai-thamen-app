import 'package:flutter/material.dart';

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
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
            child: const Text("Choose Wisely",
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: OutlineButton(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Image.network(
                      "https://www.fifaindex.com/static/FIFA21/images/crest/10/light/1878.webp",
                      height: MediaQuery.of(context).size.height * .15,
                    ),
                    splashColor: Colors.white,
                    highlightedBorderColor: Colors.teal,
                    onPressed: () {
                      Navigator.of(context).pop("medical");
                    },
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child: OutlineButton(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Image.network(
                      "https://www.fifaindex.com/static/FIFA20/images/crest/10/light/1028.webp",
                      height: MediaQuery.of(context).size.height * .15,
                    ),
                    splashColor: Colors.white,
                    highlightedBorderColor: Colors.teal,
                    onPressed: () {
                      Navigator.of(context).pop("toilets");
                    },
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
