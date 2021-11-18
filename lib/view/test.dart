import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);
  final List s = ['Home', 'Personal', 'Misc'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10.0),
            itemCount: s.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    s[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
