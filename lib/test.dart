import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';//barcode
import 'package:shared_preferences/shared_preferences.dart';


void main(){
  runApp(new MaterialApp(
    title: 'Navigation Basics',
    home: StampSE(),
    //home: StampTable(),
    //home: AddStamp(),

  ));
}
//Stamp SE
class StampSE extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STAMP SE'),
      ),
      body: Column(children: <Widget>[
        Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                //leading: const Icon(Icons.album),
                title: const Text('88811159'),
                subtitle:
                const Text('Essential Skills Preparation in Informatics'),
              ),
              new ButtonTheme.bar(
                // make buttons use the appropriate styles for cards
                child: new ButtonBar(
                  children: <Widget>[
                    new FlatButton(
                      child: const Text('STAMP TABLE'),
                      onPressed: () {
                        /* ... */
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StampTable()),
                        );
                      },
                    ),
                    new FlatButton(
                      child: const Text('ADD STAMP'),
                      onPressed: () {
                        /* ... */
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddStamp()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
//Stamp SE
//Stamp Table
class StampTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text("STAMP TABLE"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new SafeArea(
              top: false,
              bottom: false,
              child: new GridView.count(
                  crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(4.0),
                  childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
                  children: <Widget> [
                    Image.asset('images/se.jpg')

                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//Stamp Table
//Add Stamp
class AddStamp extends StatefulWidget {

  @override
  _ScanStamp createState() => new _ScanStamp();
}

class _ScanStamp extends State<AddStamp> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('ADD STAMP'),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Container(
                child: new MaterialButton(
                    onPressed: scan, child: new Text("Touch for Scan Stamp")),
                padding: const EdgeInsets.all(8.0),
              ),
              new Text(barcode),
            ],
          ),
        )
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
//Add Stamp
