import 'package:flutter/material.dart';

import '../../routes.dart';

class TouchIdScreen extends StatefulWidget {
  const TouchIdScreen({super.key});

  @override
  State<TouchIdScreen> createState() => _TouchIdScreenState();
}

class _TouchIdScreenState extends State<TouchIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextButton(onPressed: (){
          Navigator.pushNamed(context,RouteNames.tabRoute);
        }, child:Text("NEXT"))
      ],),
    );
  }
}
