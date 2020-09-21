import 'package:flutter/material.dart';
import 'package:flutter_particle_bg/flutter_particle_bg.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二个页面'),
        elevation: 0.0,
      ),
      body: MooooooBackground(
        bgimg: AssetImage('assets/bg.png'),
        child: ListView(
          children: [
            ListTile(
              title: Text('测试第二个界面'),
            )
          ],
        ),
      ),
    );
  }
}
