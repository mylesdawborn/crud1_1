import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Post Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Post CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(icon: Icon(FontAwesomeIcons.bars), onPressed: () {}),
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.newspaper,
                size: 20.0,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: StreamBuilder(
        // ignore: missing_return
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            const Text('Loading');
          } else {
            // ignore: missing_return
            return ListView.builder(
              itemBuilder: (context, index) {
                DocumentSnapshot myPost = snapshot.data.documents[index];
                // ignore: missing_return
                return Stack(
                  children: <Widget>[
                    Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context)
                            .size
                            .width, //Device screen width
                        height: 360.0,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Material(
                            color: Colors.white,
                            elevation: 14.0,
                            shadowColor: Colors.blue,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () => launch('${myPost['link']}'),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200.0,
                                        child: Image.network(
                                          '${myPost['image']}',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        '${myPost['title']}',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${myPost['subtitle']}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.blueGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .47,
                          left: MediaQuery.of(context).size.height * .52),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: snapshot.data.documents.length,
            );
          }
        },
        stream: Firestore.instance.collection('post').snapshots(),
      ),
    );
  }
}
