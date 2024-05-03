import 'package:flutter/material.dart';

import '../../routes.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key});

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextButton(onPressed: (){
          Navigator.pushNamed(context,RouteNames.touchIdRoute);
        }, child:Text("NEXT"))
      ],),
    );
  }
}
