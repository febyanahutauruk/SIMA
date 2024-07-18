import 'package:flutter/material.dart';

class IconHomeWidget extends StatelessWidget {
  const IconHomeWidget({super.key, required this.routename, required this.lable, required this.icons});

final String routename;
final String lable;
final String icons;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(20),
        color: Colors.teal,
      ),
                  width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.width/4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/$icons',
                      height: 40,
                        width: 40),

                      // IconButton(
                      //   icon: Image.asset('assets/icons/assets.png',
                      //   height: 10,
                      //   width: 10,),
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, routename);
                      //   },
                      // ),
                      Text(lable,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center),
                    ],
                  ),
                );
  }
}