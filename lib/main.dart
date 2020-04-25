import 'package:flutter/material.dart';

void main() => (runApp(new App()));

/// @description:
/// @author xcl qq:244672784
/// @Date 2020/4/25 10:42
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("App")
        ),
        body: Container(),
      ),

    );
  }
}