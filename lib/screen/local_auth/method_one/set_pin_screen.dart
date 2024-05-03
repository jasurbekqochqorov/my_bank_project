import 'package:flutter/material.dart';
import 'package:my_bank_project/screen/routes.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextButton(onPressed: (){
          Navigator.pushNamed(context,RouteNames.confirmPinRoute);
        }, child:Text("NEXT"))
      ],),
    );
  }
}
