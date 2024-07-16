import 'package:flutter/material.dart';

class IconHomeWidget extends StatelessWidget {
  const IconHomeWidget({super.key, required this.routename, required this.lable, required this.icons});

final String routename;
final String lable;
final IconData icons;
  @override
  Widget build(BuildContext context) {
    return Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(icons),
                        onPressed: () {
                          Navigator.pushNamed(context, routename);
                        },
                      ),
                      Text(lable,
                      textAlign: TextAlign.center),
                    ],
                  ),
                );
  }
}