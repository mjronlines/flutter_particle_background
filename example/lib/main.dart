// import 'package:example/exp.dart';
// import './exp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_particle_bg/flutter_particle_bg.dart';
// import 'exp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MooooooBackground(
          bgimg: AssetImage('assets/bg.png'),
          child: ListView(
            children: [
              Text('列表元素'),
              Container(
                height: 500,
                color: Colors.red[200].withOpacity(0.6),
                margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                alignment: Alignment.center,
                child: Text('这是列表元1素'),
              )
            ],
          ),
        ));
  }
}
