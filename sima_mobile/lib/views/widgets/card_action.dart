import 'package:flutter/material.dart';

class CardAction extends StatelessWidget {
  const CardAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              
            },
            child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 60,
                  padding: EdgeInsets.all(16),              child: Center(
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
