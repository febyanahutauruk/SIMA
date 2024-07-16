import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BottomSheet(),
    debugShowCheckedModeBanner: false,
  ));
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({super.key});

  @override
  State<BottomSheet> createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Sheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Show Modal Bottom Sheet'),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  width: 419,
                  height: 352,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('This is a Modal Bottom Sheet'),
                      ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
