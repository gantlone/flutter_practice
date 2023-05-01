import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyButton(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neumorphic Button Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Neumorphic Button Demo'),
        ),
        body: Center(
          child: NeumorphicButton(
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              depth: 8,
              intensity: 0.5,
              color: Colors.blueGrey,
            ),
            onPressed: () {},
            child: Text(
              'Click Me',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
