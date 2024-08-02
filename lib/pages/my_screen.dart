import 'package:flutter/material.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('Миний тухай'),
        centerTitle: true,
        backgroundColor: Colors.yellow[400],
      ),
      body: (const Padding(
          padding: EdgeInsets.all(15),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('lib/assets/profile.JPG'),
                    radius: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Батжаргалын Батмөнх',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  )
                  ,Text(
                      'Сайн байна уу. Би Flutter Mobile хөгжүүлэгч байна.'
                  )
                ],
              )))),
    );
  }
}
