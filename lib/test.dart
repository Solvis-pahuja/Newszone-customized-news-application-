import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return mybutton('Button') ;
  }
  Widget mybutton (String mytext){
    return Container(child: Center(child: Text(mytext),),);
  }
}
