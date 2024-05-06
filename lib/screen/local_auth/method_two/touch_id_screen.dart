import 'package:flutter/material.dart';
import 'package:my_bank_project/data/local/storage_repository.dart';
import 'package:my_bank_project/services/boimetric_auth_service.dart';
import 'package:my_utils/my_utils.dart';

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
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.fingerprint,size: 150.w),
          TextButton(onPressed:enabledBio, child:const Text("Boimetric auth")),
            TextButton(onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, RouteNames.tabRoute, (route) => false);
            }, child:Text("skip"))
        ],),
      ),
    );
  }
  Future<void> enabledBio()async{
    bool authenticated=await BiometricAuthService.authenticate();
    if(authenticated){
      await StorageRepository.setBool(key: 'biometrics', value:true);
      if(!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Boimetrics saved"))
      );
    }
    else{
      if(!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Boimetrics Error"))
      );
    }
    if(!context.mounted) return;
    // Navigator.pushNamedAndRemoveUntil(context, RouteNames.tabRoute, (route) => false);
  }
}
